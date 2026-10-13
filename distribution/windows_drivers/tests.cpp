// Read-only native tests: INF parsing, interface filtering and argument escaping.
#define wmain driver_helper_main
#include "helper.cpp"
#undef wmain
#include <fstream>
#include <cassert>

int wmain() {
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
    std::cout << "Native driver helper read-only tests passed.\n";
    return 0;
}
