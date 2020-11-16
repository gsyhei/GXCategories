//
//  Dictionry+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/9.
//  Copyright © 2020 Gin. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    static func dictionaryWithPlistData(_ data: Data) -> Dictionary? {
        do {
            let dictionary = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
            return dictionary as? Dictionary
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
    static func arrayWithPlistString(_ string: String) -> Dictionary? {
        guard let data = string.data(using: .utf8) else { return nil }
        return self.dictionaryWithPlistData(data)
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
    
    func sortedKeys(isOrderedBefore:(Key, Key) -> Bool) -> [Key] {
        return Array(self.keys).sorted(by: isOrderedBefore)
    }
    
    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return sortedKeys {
            isOrderedBefore(self[$0]!, self[$1]!)
        }
    }
    
    func sortedValuesByKeys(isOrderedBefore:(Key, Key) -> Bool) -> [Value] {
        let sortedKeys = self.sortedKeys(isOrderedBefore: isOrderedBefore)
        var array: [Value] = []
        for key in sortedKeys {
            if let value = self[key] {
                array.append(value)
            }
        }
        return array
    }
    
    func jsonStringEncoded(options opt:JSONSerialization.WritingOptions = []) -> String? {
        if JSONSerialization.isValidJSONObject(self) {
            let data = try? JSONSerialization.data(withJSONObject: self, options: opt)
            guard data != nil else { return nil }
            return String(data: data!, encoding: .utf8)
        }
        return nil
    }
    
}
