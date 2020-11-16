//
//  UIDevice+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/10.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    class func getIPAddresses() -> String? {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first
    }
    
    var systemVersionFloat: Float? {
        return Float(self.systemVersion)
    }
    
    var isPad: Bool {
        if #available(iOS 13.0, *) {
            return self.userInterfaceIdiom == .pad
        }
        else {
            return UI_USER_INTERFACE_IDIOM() == .pad
        }
    }
    
    var isSimulator: Bool {
        let range = self.model.range(of: "Simulator")
        return range != nil
    }
    
    var isJailbroken: Bool {
        if self.isSimulator { return false }
        let paths = ["/Applications/Cydia.app", "/private/var/lib/apt/",
                     "/private/var/lib/cydia", "/private/var/stash"];
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        let bash = fopen("/bin/bash", "r")
        if bash != nil {
            fclose(bash)
            return true
        }
        let path = String(format: "/private/%@", String.stringWithUUID() ?? "")
        do {
            try "test".write(toFile: path, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            NSLog(error.localizedDescription)
        }
        return false
    }
    
    var systemUptime: Date {
        let time = ProcessInfo.processInfo.systemUptime
        return Date(timeIntervalSinceNow: (0 - time))
    }
 
    var diskSpace: Int64 {
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let space: NSNumber = attrs[FileAttributeKey.systemSize] as? NSNumber {
                if space.int64Value > 0 {
                    return space.int64Value
                }
            }
        }
        return -1
    }
    
    var diskSpaceFree: Int64 {
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let space: NSNumber = attrs[FileAttributeKey.systemFreeSize] as? NSNumber {
                if space.int64Value > 0 {
                    return space.int64Value
                }
            }
        }
        return -1
    }
    
    var diskSpaceUsed: Int64 {
        let total = self.diskSpace
        let free = self.diskSpaceFree
        guard total > 0 && free > 0 else { return -1 }
        let used = total - free
        guard used > 0 else { return -1 }
        
        return used
    }
    
    var memoryTotal: UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }
    
    var memoryUsed: Int64 {
        let host_port = mach_host_self()
        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)
        var page_size: vm_size_t = 0
        var vm_stat: integer_t = 0
        var kern: kern_return_t = 0
        kern = _host_page_size(host_port, &page_size)
        if kern != KERN_SUCCESS { return -1 }
        kern = host_statistics(host_port, HOST_VM_INFO, &vm_stat, &host_size)
        if kern != KERN_SUCCESS { return -1 }
        
        return Int64(page_size) * Int64(vm_stat)
    }
    
    func canMakePhoneCalls() -> Bool {
        if let url = URL(string: "tel://") {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    static func modelName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case"iPod5,1":
            return"iPod Touch 5"
        case"iPod7,1":
            return"iPod Touch 6"
            
        case"iPhone3,1", "iPhone3,2", "iPhone3,3":
            return"iPhone4"
        case"iPhone4,1":
            return"iPhone4s"
        case"iPhone5,1","iPhone5,2":
            return"iPhone5"
        case"iPhone5,3", "iPhone5,4":
            return"iPhone5c"
        case"iPhone6,1", "iPhone6,2":
            return"iPhone5s"
        case"iPhone7,2":
            return"iPhone6"
        case"iPhone7,1":
            return"iPhone6 Plus"
        case"iPhone8,1":
            return"iPhone6s"
        case"iPhone8,2":
            return"iPhone6s Plus"
        case"iPhone8,4":
            return"iPhoneSE"
        case"iPhone9,1", "iPhone9,3":
            return"iPhone7"
        case"iPhone9,2", "iPhone9,4":
            return"iPhone7 Plus"
        case"iPhone10,1", "iPhone10,4":
            return"iPhone8"
        case"iPhone10,5", "iPhone10,2":
            return"iPhone8 Plus"
        case"iPhone10,3", "iPhone10,6":
            return"iPhoneX"
        case"iPhone11,2":
            return"iPhoneXS"
        case"iPhone11,6":
            return"iPhoneXS MAX"
        case"iPhone11,8":
            return"iPhoneXR"
        case"iPhone12,1":
            return"iPhone11"
        case"iPhone12,3":
            return"iPhone11 ProMax"
        case"iPhone12,5":
            return"iPhone11 Pro"
            
        case"iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return"iPad 2"
        case"iPad3,1", "iPad3,2", "iPad3,3":
            return"iPad 3"
        case"iPad3,4", "iPad3,5", "iPad3,6":
            return"iPad 4"
        case"iPad4,1", "iPad4,2", "iPad4,3":
            return"iPad Air"
        case"iPad5,3","iPad5,4":
            return"iPad Air 2"
        case"iPad2,5", "iPad2,6", "iPad2,7":
            return"iPad Mini"
        case"iPad4,4", "iPad4,5", "iPad4,6":
            return"iPad Mini 2"
        case"iPad4,7", "iPad4,8", "iPad4,9":
            return"iPad Mini 3"
        case"iPad5,1","iPad5,2":
            return"iPad Mini 4"
        case"iPad6,7","iPad6,8":
            return"iPad Pro"
            
        case"AppleTV5,3":
            return"Apple TV"
        case"i386","x86_64":
            return"Simulator"
        default:
            return identifier
        }
    }

}
