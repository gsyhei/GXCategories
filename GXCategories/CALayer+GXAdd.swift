//
//  CALayer+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/9/20.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension CALayer {
    
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
    
    var center: CGPoint {
        set {
            var frame = self.frame
            frame.origin.x = newValue.x - frame.width * 0.5
            frame.origin.y = newValue.y - frame.height * 0.5
            self.frame = frame
        }
        get {
            let cx = self.frame.origin.x + self.frame.width * 0.5
            let cy = self.frame.origin.y + self.frame.height * 0.5
            return CGPoint(x: cx, y: cy)
        }
    }
    
    var centerX: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.width * 0.5
            self.frame = frame
        }
        get {
            self.frame.origin.x + self.frame.width * 0.5
        }
    }
    
    var centerY: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.height * 0.5
            self.frame = frame
        }
        get {
            self.frame.origin.x + self.frame.width * 0.5
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
    
    func removeAllSubviews() {
        if let layers = self.sublayers {
            layers.forEach { (sublayer) in
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    func setStyleCircle() {
        self.masksToBounds = true
        self.cornerRadius = self.frame.size.height/2
    }
    
    func setMaskImage(_ image: UIImage?, dx: CGFloat, dy: CGFloat) {
        let imageViewMask = UIImageView(image: image)
        imageViewMask.frame = self.frame.insetBy(dx: dx, dy: dy)
        self.mask = imageViewMask.layer
    }
    
    func setRoundedCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let rect = self.bounds
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        self.mask = maskLayer
    }
    
    func setLayerShadow(color:UIColor?, offset:CGSize, radius:CGFloat) {
        self.shadowColor = color?.cgColor
        self.shadowOffset = offset
        self.shadowRadius = radius
        self.shadowOpacity = 1;
        self.shouldRasterize = true
        self.rasterizationScale = UIScreen.main.scale
    }
    
    func addGradientLayer(frame: CGRect, colors: [CGColor], start startPoint: CGPoint, end endPoint: CGPoint ,locations:[NSNumber]? = nil) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        self.insertSublayer(gradientLayer, at: 0)
    }
    
    func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        self.render(in: context)
        let snapImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return snapImage
    }
    
    func snapshotPDF() -> NSData? {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, self.bounds, nil)
        UIGraphicsBeginPDFPage()
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return nil }
        self.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        
        return pdfData
    }
}
