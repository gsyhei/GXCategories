//
//  UIApplication+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/11.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

fileprivate extension UIApplication {
    class func gx_fileExistInMainBundle(name: String) -> Bool {
        let bundlePath = Bundle.main.bundlePath
        let path = (bundlePath as NSString).appendingPathComponent(name)
        return FileManager.default.fileExists(atPath: path)
    }
}

public extension UIApplication {
    
    class func documentsURL() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    class func documentsPath() -> String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }

    class func cachesURL() -> URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    }

    class func cachesPath() -> String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
    class func libraryURL() -> URL? {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
    }

    class func libraryPath() -> String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }
    
    class func isPirated() -> Bool {
        if UIDevice.current.isSimulator { return true }
        
        if getgid() <= 10 { return true } // process ID shouldn't be root
        
        if ((Bundle.main.infoDictionary?["SignerIdentity"]) != nil) {
            return true
        }
        if !self.gx_fileExistInMainBundle(name: "SignerIdentity") {
            return true
        }
        if !self.gx_fileExistInMainBundle(name: "SC_Info") {
            return true
        }
        
        return false
    }
    
    class func appDisplayName() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    class func appBundleName() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    class func appBundleID() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
    }
    
    class func appVersion() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    class func appBuildVersion() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
