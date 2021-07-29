//
//  UIView+GXAdd.swift
//  GXSwiftKit
//
//  Created by Gin on 2020/5/23.
//  Copyright © 2019 gin. All rights reserved.
//

import UIKit
import Foundation

public extension UIView {
    
    var left:CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var top:CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var right:CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    var bottom:CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    var width:CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height:CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    var centerX:CGFloat {
        set {
            self.center = CGPoint(x:newValue, y:self.center.x)
        }
        get {
            return self.center.x
        }
    }
    
    var centerY:CGFloat {
        set {
            self.center = CGPoint(x:self.center.x, y:newValue)
        }
        get {
            return self.center.y
        }
    }
    
    var origin:CGPoint {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    
    var size:CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    var visibleAlpha:CGFloat {
        get {
            if (self is UIWindow) {
                if self.isHidden { return 0 }
                return self.alpha
            }
            guard self.window != nil else { return 0 }
            var alpha: CGFloat = 1.0
            var view: UIView? = self
            while view != nil {
                if view!.isHidden { alpha = 0; break }
                alpha = view!.alpha
                view = view?.superview
            }
            return alpha
        }
    }
    
    /// 获取xib视图
    /// - Parameters:
    ///   - name: xib名
    ///   - index: 视图索引（xib允许存在多个独立view）
    /// - Returns: 对应视图
    class func xibView(_ name: String, index: Int = 0) -> Self {
        let nibView = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?[index]
        guard let view = nibView as? Self else {
            fatalError("The xib view is incorrect.")
        }
        return view
    }
    
    /// 获取xib视图
    /// - Parameters:
    ///   - index: 视图索引（xib允许存在多个独立view）
    /// - Returns: 对应视图
    class func xibView(index: Int = 0) -> Self {
        let nibView = Bundle.main.loadNibNamed(self.className(), owner: nil, options: nil)?[index]
        guard let view = nibView as? Self else {
            fatalError("The xib view is incorrect.")
        }
        return view
    }
    
    func currentWindow() -> UIWindow? {
        let window = UIApplication.shared.windows.first
        guard window != nil else {
            return UIApplication.shared.delegate?.window ?? nil
        }
        return window
    }
    
    func viewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: {$0?.superview}){
            if let responder = view?.next{
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    func removeAllSubviews() {
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
    
    func setStyleCircle() {
        self.layer.setStyleCircle()
    }
    
    func setMaskImage(_ image: UIImage?, dx: CGFloat, dy: CGFloat) {
        self.layer.setMaskImage(image, dx: dx, dy: dy)
    }
    
    func setRoundedCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.layer.setRoundedCorners(corners, radius: radius)
    }
    
    func setLayerShadow(color:UIColor?, offset:CGSize, radius:CGFloat) {
        self.layer.setLayerShadow(color: color, offset: offset, radius: radius)
    }
    
    func addGradientLayer(frame: CGRect, colors: [CGColor], start startPoint: CGPoint, end endPoint: CGPoint ,locations:[NSNumber]? = nil) {
        self.layer.addGradientLayer(frame: self.bounds, colors: colors, start: startPoint, end: endPoint, locations: locations)
    }
    
    func snapshotImage() -> UIImage? {
        return self.layer.snapshotImage()
    }
    
    @available(iOS 7.0, *)
    func snapshotImage(afterScreenUpdates afterUpdates: Bool) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: afterUpdates)
        let snapImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return snapImage
    }
    
    func snapshotPDF() -> NSData? {
        return self.layer.snapshotPDF()
    }
}

@IBDesignable
public extension UIView {
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        } set {
            self.layer.masksToBounds = newValue
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        } set {
            self.layer.borderColor = newValue.cgColor
        }
    }
}
