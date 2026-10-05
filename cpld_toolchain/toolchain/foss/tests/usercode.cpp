// SPDX-License-Identifier: Apache-2.0
#include "machxo2_usercode.hpp"
#include <cassert>
#include <vector>
int main()
{
    const uint32_t expected = 0x89abcdef;
    std::vector<int> calls;
    auto write = [&](uint8_t command, uint8_t *bytes, int size) {
        calls.push_back(1);
        assert(command == 0xc2 && size == 4);
        assert(bytes[0] == 0xef && bytes[1] == 0xcd && bytes[2] == 0xab && bytes[3] == 0x89);
        return true;
    };
    auto wait = [&]() {calls.push_back(2); return true;};
    auto read = [&]() {calls.push_back(3); return expected;};
    assert(program_machxo2_usercode(expected, write, wait, read));
    assert((calls == std::vector<int>{1, 2, 3}));
    calls.clear();
    assert(!program_machxo2_usercode(expected, write, wait, []() {return 0u;}));
    assert((calls == std::vector<int>{1, 2}));
    calls.clear();
    assert(!program_machxo2_usercode(expected, write, []() {return false;}, read));
    assert((calls == std::vector<int>{1}));
    calls.clear();
    assert(!program_machxo2_usercode(expected, [](uint8_t, uint8_t *, int) {return false;}, wait, read));
    assert(calls.empty());
}
