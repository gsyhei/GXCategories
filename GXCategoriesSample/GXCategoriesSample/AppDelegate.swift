//
//  AppDelegate.swift
//  GXCategoriesSample
//
//  Created by Gin on 2020/11/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Bundle.gx_loadLanguage()
        NSLog("%@当前国际化：%@", GXBundle.userLanguage ?? "", GXLSTR("按钮"))
        
        // 进制转换
        let num: UInt8 = 111
        let bit0 = num.gx_readBit(index: 0)
        let bit1 = num.gx_readBit(index: 1)
        let bit2 = num.gx_readBit(index: 2)
        let bit3 = num.gx_readBit(index: 3)
        let bit4 = num.gx_readBit(index: 4)
        let bit5 = num.gx_readBit(index: 5)
        let bit6 = num.gx_readBit(index: 6)
        let bit7 = num.gx_readBit(index: 7)
        let readNumber = num.gx_numberVal(range: NSRange(location: 1, length: 4))
        NSLog("num: \(num.gx_bString), readNumber: \(readNumber)")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

