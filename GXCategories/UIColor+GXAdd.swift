//
//  UIColor+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/12.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner   = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            if #available(iOS 13.0, watchOS 6.0, tvOS 13.0, macOS 10.15, *) {
                scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
            } else {
                scanner.scanLocation = 1
            }
        }
        var color: UInt64 = 0
        if scanner.scanHexInt64(&color) {
            self.init(hex: UInt32(color), useAlpha: hexString.count > 7)
        }
        else {
            self.init(hex: 0x000000)
        }
    }
    
    convenience init(hex: UInt32, useAlpha alphaChannel: Bool = false) {
        let mask = 0xFF
        let r = Int(hex >> (alphaChannel ? 24 : 16)) & mask
        let g = Int(hex >> (alphaChannel ? 16 : 8)) & mask
        let b = Int(hex >> (alphaChannel ? 8 : 0)) & mask
        let a = alphaChannel ? Int(hex) & mask : 255
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        let alpha = CGFloat(a) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    
    class func hex(hexString: String) -> UIColor {
        return self.hexWithAlpha(hexString: hexString, alpha: 1.0)
    }
    
    class func hexWithAlpha(hexString: String, alpha:CGFloat) -> UIColor {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let rgbLength: Int = 6
        if cString.count < rgbLength { return UIColor.black }
        
        let index = cString.index(cString.endIndex, offsetBy: -rgbLength)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }
        if cString.count != 6 { return UIColor.black }
 
        var r: UInt64 = 0x0, g: UInt64 = 0x0, b: UInt64 = 0x0
        Scanner(string: cString[0,2]).scanHexInt64(&r)
        Scanner(string: cString[2,2]).scanHexInt64(&g)
        Scanner(string: cString[4,2]).scanHexInt64(&b)
        
        return UIColor(r: UInt32(r), g: UInt32(g), b: UInt32(b), a: alpha)
    }

    class func dynamicColor(light: UIColor, drak: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { collection in
                return collection.userInterfaceStyle == .dark ? drak : light
            }
        }
        return light
    }

    class var random: UIColor {
        return UIColor(r: arc4random_uniform(256),
                       g: arc4random_uniform(256),
                       b: arc4random_uniform(256))
    }
    
}
