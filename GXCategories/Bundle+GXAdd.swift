//
//  Bundle+GXAdd.swift
//  GXCategoriesSample
//
//  Created by Gin on 2022/4/8.
//

import Foundation

public func GXLSTR(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String = "") -> String {
    return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
}

public class GXBundle: Bundle {
    static let GXUserLanguageKey = "GXUserLanguageKey"
    static let AppleLanguages = "AppleLanguages"
    
    private class var gx_main: Bundle? {
        if let language = Bundle.currentLanguage, language.count > 0 {
            let path = Bundle.main.path(forResource: Bundle.currentLanguage, ofType: "lproj")
            if let thePath = path {
                return Bundle(path: thePath)
            }
        }
        return nil
    }
    
    public class var userLanguage: String? {
        set {
            guard let value = newValue, value.count > 0 else {
                self.resetSystemLanguage()
                return
            }
            UserDefaults.standard.setValue(value, forKey: GXUserLanguageKey)
            UserDefaults.standard.setValue([value], forKey: AppleLanguages)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: GXUserLanguageKey)
        }
    }
    
    public class func resetSystemLanguage() {
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
    class func gx_loadLanguage() {
        object_setClass(Bundle.main, GXBundle.self)
    }
    
    class var currentLanguage: String? {
        if let language = GXBundle.userLanguage, language.count > 0 {
            return language
        }
        return NSLocale.preferredLanguages.first
    }
    
    class var isChineseLanguage: Bool {
        if let language = self.currentLanguage, language.count > 0 {
            return language.hasPrefix("zh-")
        }
        return false
    }
}
