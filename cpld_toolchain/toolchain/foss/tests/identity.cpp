// SPDX-License-Identifier: Apache-2.0
#include "machxo2_identity.hpp"
#include "uz_checked_io.hpp"
#include <cassert>
#include <string>
#include <vector>
int main() {
    // Distinct devices, Flash/SRAM values, high bits, and every failure point.
    for (unsigned index = 0; index < 5; ++index) {
        for (int fail = -1; fail < 8; ++fail) {
            std::vector<int> calls;
            int operation = 0;
            bool enabled = false;
            auto step = [&](int cmd) { calls.push_back(cmd); if (operation++ == fail) throw std::runtime_error("injected"); };
            try {
                auto v = read_machxo2_identity(
                    [&](uint8_t cmd, unsigned n) -> uint64_t {
                        step(cmd);
                        if (cmd == 0x3c) return 0;
                        if (cmd == 0xe0) {assert(n == 4); return 0x012bb043;}
                        if (cmd == 0xc0) return (enabled ? 0x80000000u : 0x90000000u) + index;
                        assert(cmd == 0x19 && n == 8); return 0xff12345678000000ULL + index;
                    },
                    [&]() {enabled = true; step(0x74);},
                    [&]() {step(0x26); enabled = false;},
                    [&]() {step(0xff);});
                assert(fail == -1);
                assert(v.flash_usercode == 0x80000000u + index);
                assert(v.sram_usercode == 0x90000000u + index);
                assert(v.traceid == 0xff12345678000000ULL + index);
                assert((calls == std::vector<int>{0x3c, 0xe0, 0xc0, 0x74, 0xc0, 0x26, 0x19, 0xff}));
            } catch (const std::runtime_error &e) {
                assert(fail >= 0 && std::string(e.what()) == "injected");
                assert(calls.back() == 0xff);
            }
            assert(!enabled);
        }
    }
    bool disabled = false, bypassed = false;
    try {
        read_machxo2_identity([](uint8_t, unsigned) -> uint64_t {return 1u << 9;},
            []() {assert(false);}, [&]() {disabled = true;}, [&]() {bypassed = true;});
        assert(false);
    } catch (const std::runtime_error &) {assert(!disabled && bypassed);}
    uint8_t bytes[8] = {};
    int offset = 0;
    assert(uz_read_exact(bytes, 8, [&](uint8_t *p, int n) {
        assert(n == 8-offset); *p = 0xff; ++offset; return 1;
    }, []() {return false;}) == 8);
    assert(uz_little_endian(bytes, 8) == 0xffffffffffffffffULL);
    for (int n : {-1, 0, 7}) {
        try {uz_check_write(n, 8); assert(false);} catch (const std::runtime_error &) {}
    }
    uz_check_write(8, 8);
    for (int returned : {-1, 0, 9}) {
        int polls = 0;
        try {
            uz_read_exact(bytes, 8, [&](uint8_t *, int) {return returned;}, [&]() {return ++polls > 3;});
            assert(false);
        } catch (const std::runtime_error &) {assert(polls <= 4);}
    }
}
