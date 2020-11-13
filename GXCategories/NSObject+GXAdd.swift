//
//  NSObject+GXAdd.swift
//  CPTProduct
//
//  Created by Gin on 2020/5/23.
//  Copyright © 2019 gin. All rights reserved.
//

import UIKit

public extension NSObject {
    
    class func className() -> String {
        return String(describing: self)
    }
    
    class func swizzleInstanceMethod(originalSel: Selector, newSel: Selector) -> Bool {
        let originalMethod = class_getInstanceMethod(self, originalSel)
        let newMethod = class_getInstanceMethod(self, newSel)
        guard originalMethod != nil && newMethod != nil else { return false }
        method_exchangeImplementations(originalMethod!, newMethod!)
        return true
    }
    
    class func swizzleClassMethod(originalSel: Selector, newSel: Selector) -> Bool {
        let originalMethod = class_getClassMethod(self, originalSel)
        let newMethod = class_getClassMethod(self, newSel)
        guard originalMethod != nil && newMethod != nil else { return false }
        method_exchangeImplementations(originalMethod!, newMethod!)
        return true
    }
    
    func className() -> String {
        return String(describing: self)
    }
    
    func setAssociateStrongValue(_ value: Any, key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func setAssociateWeakValue(_ value: Any, key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_ASSIGN);
    }
    
    func getAssociatedValue<T: Any>(key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }
    
    func removeAssociatedValues() {
        objc_removeAssociatedObjects(self)
    }

    @available(iOS, introduced: 2.0, deprecated: 12.0, message: "Use deepCopy(requiresSecureCoding:) instead")
    func deepCopy<T: NSObject>() -> T? {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: self)
        let copyObject = NSKeyedUnarchiver.unarchiveObject(with: archivedData)
        return copyObject as? T
    }
    
    @available(iOS 11.0, *)
    func deepCopy<T: Any>(requiringSecureCoding requiresSecureCoding: Bool) -> T? {
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: requiresSecureCoding)
            let copyObject = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [self], from: archivedData)
            return copyObject as? T
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
    @available(iOS, introduced: 2.0, deprecated: 12.0, message: "Use deepCopy(archiver:unarchiver:requiresSecureCoding:) instead")
    func deepCopy<T: NSObject>(archiver: AnyClass, unarchiver: AnyClass) -> T? {
        let archivedData = archiver.archivedData(withRootObject: self)
        let copyObject = unarchiver.unarchiveObject(with: archivedData)
        return copyObject as? T
    }
    
    @available(iOS 11.0, *)
    func deepCopy<T: Any>(archiver: AnyClass, unarchiver: AnyClass, requiresSecureCoding: Bool) -> T? {
        do {
            let archivedData = try archiver.archivedData(withRootObject: self, requiringSecureCoding: requiresSecureCoding)
            let copyObject = try unarchiver.unarchivedObject(ofClasses: [self], from: archivedData)
            return copyObject as? T
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
}
