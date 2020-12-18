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
    
    /// 不要犯傻，要用你交换方法的类名来调用[不要使用NSObject.swizzleInstanceMethod]
    class func swizzleInstanceMethod(originalSel: Selector, targetSel: Selector) -> Bool {
        let originalMethod = class_getInstanceMethod(self, originalSel)
        let targetMethod = class_getInstanceMethod(self, targetSel)
        guard originalMethod != nil && targetMethod != nil else { return false }
        if let originalImp = class_getMethodImplementation(self, originalSel) {
            class_addMethod(self, originalSel, originalImp, method_getTypeEncoding(originalMethod!))
        }
        if let targetImp = class_getMethodImplementation(self, targetSel) {
            class_addMethod(self, targetSel, targetImp, method_getTypeEncoding(targetMethod!))
        }
        method_exchangeImplementations(originalMethod!, targetMethod!)
        return true
    }
    
    /// 不要犯傻，要用你交换方法的类名来调用[不要使用NSObject.swizzleClassMethod]
    class func swizzleClassMethod(originalSel: Selector, targetSel: Selector) -> Bool {
        let originalMethod = class_getClassMethod(self, originalSel)
        let targetMethod = class_getClassMethod(self, targetSel)
        guard originalMethod != nil && targetMethod != nil else { return false }
        method_exchangeImplementations(originalMethod!, targetMethod!)
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
