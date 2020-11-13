//
//  Array+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/9/23.
//  Copyright © 2020 Gin. All rights reserved.
//

import Foundation

public extension Array {
    
    subscript (safe index: Int) -> Element? {
        return index < self.count ? self[index] : nil
    }
    
    static func arrayWithPlistData(_ data: Data) -> Array? {
        do {
            let array = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
            return array as? Array
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
    static func arrayWithPlistString(_ string: String) -> Array? {
        guard let data = string.data(using: .utf8) else { return nil }
        return self.arrayWithPlistData(data)
    }
    
    func plistData() -> Data? {
        do {
            let data = try PropertyListSerialization.data(fromPropertyList: self, format: .binary, options: .zero)
            return data
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
    func plistString() -> String? {
        do {
            let data = try PropertyListSerialization.data(fromPropertyList: self, format: .xml, options: .zero)
            return String(data: data, encoding: .utf8)
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }

    func jsonStringEncoded(options: JSONSerialization.WritingOptions) -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: options)
            let json = String(data: data, encoding: .utf8)
            return json
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
}
