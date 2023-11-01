//
//  UIImage+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/12.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /// 构建单色图片
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {return nil}
        self.init(cgImage:cgImage)
    }
    
    /// 构建梯度图片
    /// - Parameters:
    ///   - gradientColors: 梯度颜色数组
    ///   - locations: 位置数组：0 ~ 1
    ///   - startPoint: 开始坐标
    ///   - endPoint: 结束坐标
    ///   - size: 大小
    convenience init?(gradientColors: [UIColor], locations: [CGFloat]? = nil, start startPoint: CGPoint, end endPoint: CGPoint, size:CGSize = CGSize(width: 10, height: 10))
    {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map {(color: UIColor) -> AnyObject? in return color.cgColor as AnyObject?} as CFArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {return nil}
        self.init(cgImage:cgImage)
    }
    
    /// 构建梯度图片
    /// - Parameters:
    ///   - gradientColors: 梯度颜色数组
    ///   - locations: 位置数组：0 ~ 1
    ///   - style: 梯度风格
    ///   - size: 大小
    convenience init?(gradientColors: [UIColor], locations: [CGFloat]? = nil, style: GXGradientStyle, size: CGSize = CGSize(width: 10, height: 10))
    {
        let start: CGPoint
        let end: CGPoint
        switch style {
            case .horizontal:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x: size.width, y: 0)
            break
            case .vertical:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x:0, y: size.height)
            break
            case .obliqueUp:
            start = CGPoint(x: 0, y: size.height)
            end = CGPoint(x:size.width, y: 0)
            break
            case .obliqueDown:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x:size.width, y: size.height)
            break
        }
        self.init(gradientColors: gradientColors, locations: locations, start: start, end: end, size: size)
    }

    /// 设置动态图片（还是建议尽量在Assets.xcassets配置，bundle中必须使用此方法设置）
    /// - Parameters:
    ///   - light: 亮色图
    ///   - drak: 深色图
    /// - Returns: 当前模式图片
    class func dynamicImage(light: UIImage?, drak: UIImage?) -> UIImage? {
        if #available(iOS 13.0, *) {
            let darkTraitCollection = UITraitCollection.init(userInterfaceStyle: .dark)
            let lightTraitCollection = UITraitCollection.init(userInterfaceStyle: .light)
            let darkScaledTraitCollection = UITraitCollection.init(traitsFrom:[UITraitCollection.current, darkTraitCollection])

            var lightImage: UIImage? = nil, darkImage: UIImage? = nil
            if let lightConfig = light?.configuration?.withTraitCollection(lightTraitCollection) {
                lightImage = light?.withConfiguration(lightConfig)
            }
            if let darkConfig = drak?.configuration?.withTraitCollection(darkTraitCollection) {
                darkImage = drak?.withConfiguration(darkConfig)
            }
            if let letDarkImage = darkImage {
                lightImage?.imageAsset?.register(letDarkImage, with: darkScaledTraitCollection)
            }
            return lightImage
        }
        return light
    }

    // MARK: - 图片调整大小

    func imageByResize(to size: CGSize, drawBlock: ((CGContext) -> Void)) -> UIImage? {
        guard size.width > 0 && size.height > 0 else { return nil }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        drawBlock(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    func imageByResize(to size: CGSize) -> UIImage? {
        guard size.width > 0 && size.height > 0 else { return nil }
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    func imageByResize(to size: CGSize, mode: GXImageScaleMode) -> UIImage? {
        guard size.width > 0 && size.height > 0 else { return nil }
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.gx_draw(in: CGRect(origin: .zero, size: size), mode: mode, clipsToBounds: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func imageByCrop(ro rect: CGRect) -> UIImage? {
        guard rect.size.width > 0 && rect.size.height > 0 else { return nil }
        var drawRect: CGRect = rect
        drawRect.origin.x *= self.scale
        drawRect.origin.y *= self.scale
        drawRect.size.width *= self.scale
        drawRect.size.height *= self.scale
        guard let cgimage = self.cgImage?.cropping(to: rect) else { return nil }
        let image = UIImage(cgImage: cgimage, scale: self.scale, orientation: self.imageOrientation)
        
        return image
    }
    
    // MARK: - 图片调整尺寸+压缩大小
    
    func dataForCompression(to size: CGSize, resizeByte byte: UInt64, isDichotomy: Bool = true) -> Data? {
        let scaleImage = self.imageByResize(to: size, mode: .aspectFill)
        var quality: CGFloat = 1.0
        guard byte > 0 else { return scaleImage?.jpegData(compressionQuality: quality) }
        var imageData = scaleImage?.jpegData(compressionQuality: quality)
        if isDichotomy {
            guard imageData != nil else { return nil }
            var max: CGFloat = 1.0, min: CGFloat = 0.0
            for _ in 0..<5 {
                quality = (max + min) / 2
                imageData = scaleImage?.jpegData(compressionQuality: quality)
                guard imageData != nil else { return nil }
                if imageData!.count < Int(CGFloat(byte) * 0.9) {
                    min = quality
                }
                else if imageData!.count > byte {
                    max = quality
                }
                else {
                    break
                }
            }
        }
        else {
            while (imageData != nil && imageData!.count > byte && quality >= 0.1) {
                quality -= 0.1
                imageData = scaleImage?.jpegData(compressionQuality: quality)
            }
        }
        return imageData
    }
    
    func imageForCompression(to size: CGSize, smallWithByte byte: UInt64) -> UIImage? {
        guard byte > 0 else { return self.imageByResize(to: size, mode: .aspectFill) }
        guard let imageData = self.dataForCompression(to: size, resizeByte: byte) else { return nil }
        return UIImage(data: imageData)
    }
}

public extension UIImage {
    /// 梯度风格枚举
    enum GXGradientStyle {
        /// 水平
        case horizontal
        /// 垂直
        case vertical
        /// 倾斜向上
        case obliqueUp
        /// 倾斜向下
        case obliqueDown
    }
    /// 缩放类型
    enum GXImageScaleMode: Int {
        case clip       = 0
        case aspectFit  = 1
        case aspectFill = 2
    }
    
    /// 按风格重新计算缩放rect
    /// - Parameters:
    ///   - rect: 自定矩形区域
    ///   - mode: 缩放模式
    /// - Returns: 计算缩放后的rect
    private func gx_fitWithContentMode(rect: CGRect, mode: GXImageScaleMode) -> CGRect {
        let widthFactor = rect.size.width / self.size.width
        let heightFactor = rect.size.height / self.size.height
        switch (mode) {
        case .clip:
            let scaleFactor = max(widthFactor, heightFactor)
            let drawSize = CGSize(width: self.size.width * scaleFactor, height: self.size.height * scaleFactor)
            var left: CGFloat = 0.0, top: CGFloat = 0.0
            if (widthFactor > heightFactor) {
                top = rect.origin.y + (rect.size.height - drawSize.height) * 0.5
            }
            else if (widthFactor < heightFactor) {
                left = rect.origin.x + (rect.size.width - drawSize.width) * 0.5
            }
            return CGRect(origin: CGPoint(x: left, y: top), size: drawSize)
        case .aspectFill:
            let scaleFactor = max(widthFactor, heightFactor)
            let drawSize = CGSize(width: self.size.width * scaleFactor, height: self.size.height * scaleFactor)
            return CGRect(origin: rect.origin, size: drawSize)
        case .aspectFit:
            let scaleFactor = min(widthFactor, heightFactor)
            let drawSize = CGSize(width: self.size.width * scaleFactor, height: self.size.height * scaleFactor)
            var left: CGFloat = 0.0, top: CGFloat = 0.0
            if (widthFactor > heightFactor) {
                left = rect.origin.x + (rect.size.width - drawSize.width) * 0.5;
            }
            else if (widthFactor < heightFactor) {
                top = rect.origin.y + (rect.size.height - drawSize.height) * 0.5;
            }
            return CGRect(origin: CGPoint(x: left, y: top), size: drawSize)
        }
    }
    
    /// 按风格绘制本图片
    /// - Parameters:
    ///   - rect: 绘制rect
    ///   - mode: 缩放模式
    ///   - clipsToBounds: 是否显示边界之外/裁剪
    func gx_draw(in rect: CGRect, mode: GXImageScaleMode, clipsToBounds: Bool) {
        let drawRect = self.gx_fitWithContentMode(rect: rect, mode: mode)
        guard drawRect.size.width > 0 && drawRect.size.height > 0 else { return }
        if clipsToBounds {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            context.saveGState()
            context.addRect(rect)
            context.clip()
            self.draw(in: rect)
            context.restoreGState()
        }
        else {
            self.draw(in: rect)
        }
    }
}
