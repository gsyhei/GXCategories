//
//  Bundle+GXAdd.swift
//  GXCategoriesSample
//
//  Created by Gin on 2022/4/8.
//

import Foundation

public func GXLSTR(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

public class GXBundle: Bundle {
    static let GXUserLanguageKey = "GXUserLanguageKey"
    static let AppleLanguages = "AppleLanguages"
    
    private class var gx_main: Bundle? {
        if Bundle.currentLanguage.count > 0 {
            let path = Bundle.main.path(forResource: Bundle.currentLanguage, ofType: "lproj")
            if let thePath = path {
                return Bundle(path: thePath)
            }
        }
        return nil
    }
    
    class var userLanguage: String {
        set {
            guard newValue.count > 0 else {
                self.resetSystemLanguage()
                return
            }
            UserDefaults.standard.setValue(newValue, forKey: GXUserLanguageKey)
            UserDefaults.standard.setValue([newValue], forKey: AppleLanguages)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: GXUserLanguageKey) ?? ""
        }
    }
    
    class func resetSystemLanguage() {
        UserDefaults.standard.removeObject(forKey: GXUserLanguageKey)
        UserDefaults.standard.setValue(nil, forKey: AppleLanguages)
        UserDefaults.standard.synchronize()
    }
        
    override public func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let main = GXBundle.gx_main {
            return main.localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}


public extension Bundle {
    
    /// 需要默认加载（在didFinishLaunchingWithOptions中加入）
    class func gx_load() {
        object_setClass(Bundle.main, GXBundle.self)
    }
    
    class var currentLanguage: String {
        if GXBundle.userLanguage.count > 0 {
            return GXBundle.userLanguage
        }
        return NSLocale.preferredLanguages.first ?? ""
    }
    
    class var isChineseLanguage: Bool {
        return self.currentLanguage.hasPrefix("zh-")
    }
}
