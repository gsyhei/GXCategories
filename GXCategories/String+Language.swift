//
//  String+Language.swift
//  GXCategories
//
//  Created by Gin on 2025/5/28.
//

import Foundation

public class GXLanguageGobal: @unchecked Sendable {
    public static let shared = GXLanguageGobal()
    
    // 当前语言（默认跟随系统）
    public var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.preferredLanguages.first ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "AppLanguage")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 获取自定义 Bundle
    public func currentBundle() -> Bundle {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return Bundle.main
        }
        return bundle
    }
}

public extension String {
    var localized: String {
        let bundle = GXLanguageGobal.shared.currentBundle()
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
    static func localized(_ key: String) -> String {
        let bundle = GXLanguageGobal.shared.currentBundle()
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}
