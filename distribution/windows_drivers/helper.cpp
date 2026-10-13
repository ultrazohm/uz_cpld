// SPDX-License-Identifier: Apache-2.0
// Targeted Windows driver switching. libwdi prepares/signs WinUSB packages;
// SetupAPI installs only the selected device instance (never a hardware-ID sweep).
#ifndef UNICODE
#define UNICODE
#endif
#define _UNICODE
#define _WIN32_WINNT 0x0602
#include <windows.h>
#include <setupapi.h>
#include <newdev.h>
#include <initguid.h>
#include <devpkey.h>
#include <shellapi.h>
#include <sddl.h>
#include <libwdi.h>
#include <iostream>
#include <string>
#include <vector>
#include <stdexcept>
#include <algorithm>
#include <filesystem>

static const wchar_t* backupName = L"UzCpldOriginalDriverInf";
static std::runtime_error error(const char* msg) {
    return std::runtime_error(std::string(msg) + " (Windows error " + std::to_string(GetLastError()) + ")");
}
static std::wstring wide(const std::string& s) {
    int n = MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, s.c_str(), -1, nullptr, 0);
    if (!n) throw error("Invalid UTF-8");
    std::vector<wchar_t> out(n);
    MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, s.c_str(), -1, out.data(), n);
    return out.data();
}
static std::string utf8(const std::wstring& s) {
    int n = WideCharToMultiByte(CP_UTF8, 0, s.c_str(), -1, nullptr, 0, nullptr, nullptr);
    std::vector<char> out(n);
    WideCharToMultiByte(CP_UTF8, 0, s.c_str(), -1, out.data(), n, nullptr, nullptr);
    return out.data();
}
static std::string json(const char* s) {
    std::string out = "\"";
    for (const unsigned char c : std::string(s ? s : "")) {
        if (c == '"' || c == '\\') out += '\\';
        if (c < 32) { char escaped[7]; snprintf(escaped, sizeof escaped, "\\u%04x", c); out += escaped; }
        else out += c;
    }
    return out + '"';
}
static bool same(const std::wstring& a, const std::wstring& b) { return _wcsicmp(a.c_str(), b.c_str()) == 0; }
static std::wstring base(const std::wstring& p) { return p.substr(p.find_last_of(L"/\\") + 1); }
struct Devices {
    wdi_device_info* head = nullptr;
    Devices() {
        wdi_options_create_list opts = {}; opts.list_all = TRUE;
        int code = wdi_create_list(&head, &opts);
        if (code != WDI_SUCCESS && code != WDI_ERROR_NO_DEVICE) throw std::runtime_error(wdi_strerror(code));
    }
    ~Devices() { if (head) wdi_destroy_list(head); }
};
static bool target(wdi_device_info* d) { return d->vid == 0x0403 && d->pid == 0x6011 && d->is_composite && d->mi == 1; }
struct Device {
    HDEVINFO set;
    SP_DEVINFO_DATA data = {};
    Device(const std::wstring& id) {
        set = SetupDiCreateDeviceInfoList(nullptr, nullptr);
        if (set == INVALID_HANDLE_VALUE) throw error("Create device list");
        data.cbSize = sizeof data;
        if (!SetupDiOpenDeviceInfoW(set, id.c_str(), nullptr, 0, &data)) {
            SetupDiDestroyDeviceInfoList(set); throw error("Open selected device");
        }
    }
    ~Device() { SetupDiDestroyDeviceInfoList(set); }
    std::wstring property(const DEVPROPKEY& key) {
        wchar_t value[4096] = {}; DEVPROPTYPE type;
        if (!SetupDiGetDevicePropertyW(set, &data, &key, &type, (PBYTE)value, sizeof value, nullptr, 0)) {
            if (GetLastError() == ERROR_NOT_FOUND) return L"";
            throw error("Read device property");
        }
        if (type != DEVPROP_TYPE_STRING) throw std::runtime_error("Unexpected device property type");
        return value;
    }
    std::wstring backup(const std::wstring& save = L"") {
        HKEY key = SetupDiOpenDevRegKey(set, &data, DICS_FLAG_GLOBAL, 0, DIREG_DEV,
                                      save.empty() ? KEY_QUERY_VALUE : KEY_QUERY_VALUE | KEY_SET_VALUE);
        if (key == INVALID_HANDLE_VALUE) throw error("Open driver restore metadata");
        wchar_t value[MAX_PATH] = {}; DWORD length = sizeof value, type = 0;
        LSTATUS result = RegQueryValueExW(key, backupName, nullptr, &type, (PBYTE)value, &length);
        std::wstring previous;
        if (result == ERROR_SUCCESS && type == REG_SZ && length <= sizeof value && value[MAX_PATH-1] == 0) previous = value;
        else if (result != ERROR_FILE_NOT_FOUND) { RegCloseKey(key); throw std::runtime_error("Invalid driver restore metadata"); }
        if (!save.empty()) {
            result = RegSetValueExW(key, backupName, 0, REG_SZ, (const BYTE*)save.c_str(), (save.size()+1)*sizeof(wchar_t));
            if (result != ERROR_SUCCESS) { RegCloseKey(key); throw std::runtime_error("Cannot preserve original driver reference"); }
            RegFlushKey(key);
        }
        RegCloseKey(key); return previous;
    }
};
struct PackageDirectory {
    std::wstring path;
    ~PackageDirectory() { std::error_code ignored; std::filesystem::remove_all(path, ignored); }
};
struct Driver {
    SP_DRVINFO_DATA_W info = {};
    std::wstring inf, section;
    DWORD rank;
};
static bool ftdiService(const Driver& driver) {
    HINF inf = SetupOpenInfFileW(driver.inf.c_str(), nullptr, INF_STYLE_WIN4, nullptr);
    if (inf == INVALID_HANDLE_VALUE) return false;
    wchar_t actual[512] = {};
    bool found = false;
    if (SetupDiGetActualSectionToInstallW(inf, driver.section.c_str(), actual, 512, nullptr, nullptr)) {
        std::wstring section = std::wstring(actual) + L".Services";
        INFCONTEXT context;
        if (SetupFindFirstLineW(inf, section.c_str(), L"AddService", &context)) {
            do {
                wchar_t service[256] = {};
                if (SetupGetStringFieldW(&context, 1, service, 256, nullptr) && same(service, L"FTDIBUS")) found = true;
            } while (SetupFindNextMatchLineW(&context, L"AddService", &context));
        }
    }
    SetupCloseInfFile(inf); return found;
}
static Driver choose(Device& device, const std::wstring& onlyInf, bool diamond) {
    SetupDiDestroyDriverInfoList(device.set, &device.data, SPDIT_COMPATDRIVER);
    SP_DEVINSTALL_PARAMS_W params = {}; params.cbSize = sizeof params;
    if (!SetupDiGetDeviceInstallParamsW(device.set, &device.data, &params)) throw error("Get install parameters");
    params.Flags |= DI_QUIETINSTALL;
    if (!onlyInf.empty()) {
        if (onlyInf.size() >= MAX_PATH) throw std::runtime_error("INF path too long");
        params.Flags |= DI_ENUMSINGLEINF;
        wcscpy(params.DriverPath, onlyInf.c_str());
    } else { params.Flags &= ~DI_ENUMSINGLEINF; params.DriverPath[0] = 0; }
    if (!SetupDiSetDeviceInstallParamsW(device.set, &device.data, &params) ||
        !SetupDiBuildDriverInfoList(device.set, &device.data, SPDIT_COMPATDRIVER)) throw error("Find compatible drivers");
    std::vector<Driver> candidates;
    for (DWORD i=0;;i++) {
        Driver driver; driver.info.cbSize = sizeof driver.info;
        if (!SetupDiEnumDriverInfoW(device.set, &device.data, SPDIT_COMPATDRIVER, i, &driver.info)) {
            if (GetLastError() != ERROR_NO_MORE_ITEMS) throw error("Enumerate compatible drivers");
            break;
        }
        DWORD size = 0;
        SetupDiGetDriverInfoDetailW(device.set, &device.data, &driver.info, nullptr, 0, &size);
        if (!size) throw error("Size driver details");
        std::vector<BYTE> buffer(size);
        auto detail = reinterpret_cast<SP_DRVINFO_DETAIL_DATA_W*>(buffer.data()); detail->cbSize = sizeof *detail;
        if (!SetupDiGetDriverInfoDetailW(device.set, &device.data, &driver.info, detail, size, nullptr)) throw error("Read driver details");
        driver.inf = detail->InfFileName; driver.section = detail->SectionName;
        SP_DRVINSTALL_PARAMS install = {}; install.cbSize = sizeof install;
        if (!SetupDiGetDriverInstallParamsW(device.set, &device.data, &driver.info, &install)) throw error("Read driver rank");
        driver.rank = install.Rank;
        if (!diamond || ftdiService(driver)) candidates.push_back(driver);
    }
    if (candidates.empty()) throw std::runtime_error(diamond ?
        "No compatible FTDI driver in the Windows driver store. Install the Diamond/FTDI driver package first; no driver was changed." :
        "Prepared WinUSB driver does not match the selected interface; no driver was changed.");
    std::sort(candidates.begin(), candidates.end(), [](const Driver& a, const Driver& b) {
        if (a.rank != b.rank) return a.rank < b.rank;
        auto date = CompareFileTime(&a.info.DriverDate, &b.info.DriverDate);
        if (date) return date > 0;
        return a.info.DriverVersion > b.info.DriverVersion;
    });
    return candidates.front();
}
static bool install(Device& device, Driver driver) {
    BOOL reboot = FALSE;
    // Some MinGW import libraries omit this documented Windows API.
    HMODULE module = LoadLibraryExW(L"newdev.dll", nullptr, LOAD_LIBRARY_SEARCH_SYSTEM32);
    if (!module) throw error("Load Windows driver installation API");
    using Install = BOOL (WINAPI*)(HWND, HDEVINFO, PSP_DEVINFO_DATA, PSP_DRVINFO_DATA_W, DWORD, PBOOL);
    auto installDevice = reinterpret_cast<Install>(GetProcAddress(module, "DiInstallDevice"));
    if (!installDevice) { FreeLibrary(module); throw error("Locate DiInstallDevice"); }
    BOOL ok = installDevice(nullptr, device.set, &device.data, &driver.info, 0, &reboot);
    DWORD failure = GetLastError(); FreeLibrary(module); SetLastError(failure);
    if (!ok) throw error("Install selected device driver");
    return reboot != FALSE;
}
static bool admin() {
    SID_IDENTIFIER_AUTHORITY authority = SECURITY_NT_AUTHORITY; PSID sid = nullptr; BOOL member = FALSE;
    if (!AllocateAndInitializeSid(&authority, 2, SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0,0,0,0,0,0,&sid)) throw error("Check elevation");
    CheckTokenMembership(nullptr, sid, &member); FreeSid(sid); return member;
}
// IDs are restricted to the Windows instance-ID alphabet before elevation.
static bool validId(const std::wstring& id) {
    if (id.empty() || id.size() > 512) return false;
    for (auto c : id) if (!(iswalnum(c) || c == L'\\' || c == L'&' || c == L'_' || c == L'-')) return false;
    return true;
}
static int elevate(const std::wstring& mode, const std::wstring& id) {
    wchar_t executable[32768]; if (!GetModuleFileNameW(nullptr, executable, 32768)) throw error("Locate helper");
    std::wstring args = mode + L" \"" + id + L"\"";
    SHELLEXECUTEINFOW shell = {}; shell.cbSize = sizeof shell;
    shell.fMask = SEE_MASK_NOCLOSEPROCESS; shell.lpVerb = L"runas"; shell.lpFile = executable;
    shell.lpParameters = args.c_str(); shell.nShow = SW_SHOW;
    if (!ShellExecuteExW(&shell)) throw error("Administrator approval failed or was cancelled");
    WaitForSingleObject(shell.hProcess, INFINITE); DWORD code = 1;
    GetExitCodeProcess(shell.hProcess, &code); CloseHandle(shell.hProcess); return code;
}
static int change(const std::wstring& mode, const std::wstring& id) {
    Devices devices; wdi_device_info* selected = nullptr;
    for (auto d=devices.head; d; d=d->next) if (target(d) && d->device_id && same(wide(d->device_id), id)) selected=d;
    if (!selected) throw std::runtime_error("Selected FT4232 channel B is no longer connected; no driver was changed.");
    Device device(id);
    const auto service = device.property(DEVPKEY_Device_Service);
    const bool diamond = mode == L"--diamond";
    if (same(service, diamond ? L"FTDIBUS" : L"WinUSB")) { std::cout << "Requested driver is already bound.\n"; return 0; }
    if (diamond) {
        auto original = device.backup();
        std::wstring inf;
        if (!original.empty()) {
            if (base(original) != original || original.find(L':') != std::wstring::npos) throw std::runtime_error("Invalid saved INF name");
            wchar_t windows[MAX_PATH]; GetWindowsDirectoryW(windows, MAX_PATH);
            inf = std::wstring(windows) + L"\\INF\\" + original;
        }
        Driver chosen = choose(device, inf, true);
        std::cout << "Restoring FTDI driver: " << utf8(chosen.inf) << "\n";
        return install(device, chosen) ? 3010 : 0;
    }
    if (!service.empty() && !same(service, L"FTDIBUS"))
        throw std::runtime_error("Unrecognized current driver; refusing to replace it automatically.");
    if (same(service, L"FTDIBUS")) {
        auto original = base(device.property(DEVPKEY_Device_DriverInfPath));
        if (original.empty()) throw std::runtime_error("Cannot preserve the original FTDI driver; no driver was changed.");
        // Check that the exact original package can be selected again before switching.
        wchar_t windows[MAX_PATH]; GetWindowsDirectoryW(windows, MAX_PATH);
        choose(device, std::wstring(windows) + L"\\INF\\" + original, true);
        device.backup(original);
    }
    // Administrator-owned temporary directory: package files must not be replaceable
    // by an unelevated process while SetupAPI consumes them.
    wchar_t windows[MAX_PATH]; GetWindowsDirectoryW(windows, MAX_PATH);
    std::wstring dir = std::wstring(windows) + L"\\Temp\\uz-cpld-driver-" + std::to_wstring(GetCurrentProcessId()) + L"-" + std::to_wstring(GetTickCount64());
    PSECURITY_DESCRIPTOR sd = nullptr;
    if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(L"D:P(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)", SDDL_REVISION_1, &sd, nullptr)) throw error("Create package ACL");
    SECURITY_ATTRIBUTES sa = { sizeof sa, sd, FALSE };
    BOOL created = CreateDirectoryW(dir.c_str(), &sa); LocalFree(sd);
    if (!created) throw error("Create protected driver package directory");
    PackageDirectory cleanup{dir};
    wdi_options_prepare_driver options = {}; options.driver_type = WDI_WINUSB;
    options.vendor_name = const_cast<char*>("UltraZohm");
    int code = wdi_prepare_driver(selected, utf8(dir).c_str(), "uz_cpld_winusb.inf", &options);
    if (code) throw std::runtime_error(std::string("Prepare WinUSB driver: ") + wdi_strerror(code));
    // Stage the package without updating any matching device automatically.
    wchar_t installed[MAX_PATH] = {};
    if (!SetupCopyOEMInfW((dir+L"\\uz_cpld_winusb.inf").c_str(), nullptr, SPOST_PATH, 0, installed, MAX_PATH, nullptr, nullptr)) throw error("Stage WinUSB package");
    Driver chosen = choose(device, installed, false);
    return install(device, chosen) ? 3010 : 0;
}
int wmain(int argc, wchar_t** argv) {
    SetConsoleOutputCP(CP_UTF8);
    try {
        if (argc == 2 && same(argv[1], L"--version")) {
            if (!wdi_is_driver_supported(WDI_WINUSB, nullptr)) throw std::runtime_error("WinUSB resources missing");
            std::cout << "uz-cpld-driver-helper 2; libwdi 1.5.1; inbox WinUSB; per-instance SetupAPI\n"; return 0;
        }
        if (argc == 2 && same(argv[1], L"--list")) {
            wdi_set_log_level(WDI_LOG_LEVEL_NONE);
            Devices devices; bool first=true; std::cout << '[';
            for (auto d=devices.head; d; d=d->next) if (target(d)) {
                if (!first) std::cout << ','; first=false;
                std::cout << "{\"device_id\":" << json(d->device_id) << ",\"description\":" << json(d->desc) << ",\"service\":" << json(d->driver) << '}';
            }
            std::cout << "]\n"; return 0;
        }
        if (argc != 3 || !(same(argv[1], L"--foss") || same(argv[1], L"--diamond")) || !validId(argv[2]))
            throw std::runtime_error("Usage: uz-cpld-driver-helper --version | --list | --foss DEVICE_ID | --diamond DEVICE_ID");
        SetConsoleCtrlHandler(nullptr, TRUE);  // Keep the elevated operation and its parent together.
        if (!admin()) return elevate(argv[1], argv[2]);
        HANDLE mutex = CreateMutexW(nullptr, TRUE, L"Global\\uz-cpld-driver-setup");
        if (!mutex || GetLastError() == ERROR_ALREADY_EXISTS) throw std::runtime_error("Another driver setup is running");
        int result = change(argv[1], argv[2]); ReleaseMutex(mutex); CloseHandle(mutex);
        std::cout << (result == 3010 ? "Driver installed; restart Windows before programming.\n" : "Driver setup completed.\n");
        return result;
    } catch (const std::exception& exc) {
        std::cerr << "Driver setup failed: " << exc.what() << "\n";
        // Retain the elevated console's diagnostic when launched through runas.
        DWORD processes[2]; if (GetConsoleProcessList(processes, 2) == 1) {
            std::cerr << "Press Enter to close.\n"; std::cin.get();
        }
        return 1;
    }
}
