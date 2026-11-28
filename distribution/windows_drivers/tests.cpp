// Read-only native tests: INF parsing, interface filtering and argument escaping.
#define wmain driver_helper_main
#include "helper.cpp"
#undef wmain
#include <fstream>
#include <cassert>
#include <filesystem>

int wmain(int argc, wchar_t** argv) {
    if (argc == 4 && same(argv[1], L"--signed-package")) {
        if (!admin()) { std::cerr << "Signing test requires an elevated disposable Windows runner.\n"; return 1; }
        wdi_device_info device = {};
        device.vid=0x0403; device.pid=0x6011; device.mi=1; device.is_composite=TRUE;
        char description[]="UltraZohm CI synthetic interface"; device.desc=description;
        auto subject=utf8(argv[3]);
        wdi_options_prepare_driver options = {}; options.driver_type=WDI_WINUSB;
        options.cert_subject=subject.data();
        int code=wdi_prepare_driver(&device, utf8(argv[2]).c_str(), "test.inf", &options);
        if (code) { std::cerr << wdi_strerror(code) << "\n"; return 1; }
        return std::filesystem::is_regular_file(std::filesystem::path(argv[2]) / "test.cat") ? 0 : 1;
    }
    if (argc != 1) return 2;
    // A saved package wins while valid; stale backups fall back to the best rank.
    Driver saved = {}, newer = {};
    saved.inf=LR"(C:\Windows\INF\oem1.inf)"; saved.rank=20;
    newer.inf=LR"(C:\Windows\INF\oem2.inf)"; newer.rank=10;
    assert(same(preferredDriver({saved, newer}, L"OEM1.INF").inf, saved.inf));
    assert(same(preferredDriver({newer}, L"oem1.inf").inf, newer.inf));
    assert(same(preferredDriver({saved, newer}, L"").inf, newer.inf));
    wdi_device_info info = {};
    info.vid = 0x0403; info.pid = 0x6011; info.is_composite = TRUE;
    for (int i=0; i<4; i++) { info.mi=i; assert(target(&info) == (i==1)); }
    info.mi=1; info.is_composite=FALSE; assert(!target(&info));
    info.is_composite=TRUE; info.pid=0x6010; assert(!target(&info));
    assert(validId(L"USB\\VID_0403&PID_6011&MI_01\\6&1234&0&0001"));
    assert(!validId(L"bad\" --foss")); assert(!validId(L"bad\nargument"));
    assert(json("a\\b\"\nc") == "\"a\\\\b\\\"\\u000ac\"");
    wchar_t directory[MAX_PATH], filename[MAX_PATH];
    assert(GetTempPathW(MAX_PATH, directory));
    assert(GetTempFileNameW(directory, L"uzd", 0, filename));
    const char contents[] =
        "[Version]\r\nSignature=\"$Windows NT$\"\r\nClass=USB\r\n"
        "[FtdiBus.NTamd64]\r\n[FtdiBus.NTamd64.Services]\r\nAddService=FTDIBUS,2,FtdiService\r\n"
        "[Other.NTamd64]\r\n[Other.NTamd64.Services]\r\nAddService=WinUSB,2,WinUsbService\r\n";
    HANDLE file = CreateFileW(filename, GENERIC_WRITE, 0, nullptr, CREATE_ALWAYS, 0, nullptr);
    assert(file != INVALID_HANDLE_VALUE); DWORD written;
    assert(WriteFile(file, contents, sizeof(contents)-1, &written, nullptr)); CloseHandle(file);
    Driver driver; driver.inf=filename; driver.section=L"FtdiBus";
    assert(ftdiService(driver));
    driver.section=L"FtdiBus.NTamd64"; assert(ftdiService(driver));
    driver.section=L"Other"; assert(!ftdiService(driver));
    driver.section=L"Missing"; assert(!ftdiService(driver));
    DeleteFileW(filename);
    // Generate a package without signing, certificates, or touching any device.
    assert(wdi_is_driver_supported(WDI_WINUSB, nullptr));
    assert(!wdi_is_file_embedded(nullptr, "winusbcoinstaller2.dll"));
    assert(!wdi_is_file_embedded(nullptr, "WdfCoInstaller01011.dll"));
    assert(CreateDirectoryW(filename, nullptr));
    info.pid=0x6011; info.mi=1; info.is_composite=TRUE;
    char description[] = "UltraZohm test channel B";
    info.desc=description;
    wdi_options_prepare_driver options = {};
    options.driver_type=WDI_WINUSB; options.disable_cat=TRUE;
    int result=wdi_prepare_driver(&info, utf8(filename).c_str(), "test.inf", &options);
    assert(result == WDI_SUCCESS);
    std::ifstream generated(std::filesystem::path(filename) / "test.inf", std::ios::binary);
    std::string bytes((std::istreambuf_iterator<char>(generated)), {});
    std::string inf;
    for (size_t i=2; i+1<bytes.size(); i+=2) inf+=bytes[i]; // UTF-16LE ASCII template
    assert(inf.find("Needs = WINUSB.NT.Services") != std::string::npos);
    assert(inf.find("VID_0403&PID_6011&MI_01") != std::string::npos);
    assert(inf.find("CopyFiles") == std::string::npos);
    assert(inf.find("CoInstallers") == std::string::npos);
    assert(inf.find(".dll") == std::string::npos);
    generated.close();
    std::filesystem::remove_all(filename);
    std::cout << "Native driver helper read-only tests passed.\n";
    return 0;
}
