//
//  UIButton+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/13.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /// 快速调整图片与文字位置
    ///
    /// - Parameters:
    ///   - mode: 图片所在位置
    ///   - spacing: 文字和图片之间的间距
    func imageLocationAdjust(model: GXLocationMode, spacing: CGFloat) {
        let imageSize: CGSize = self.imageView?.frame.size ?? .zero
        let titleSize: CGSize = self.titleLabel?.intrinsicContentSize ?? .zero
        switch model {
        case .left:
            if self.contentHorizontalAlignment == .left {
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: spacing, bottom: 0, right: 0)
            }
            else if self.contentHorizontalAlignment == .right {
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: spacing)
            }
            else {
                let spacing_half = 0.5 * spacing;
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -spacing_half, bottom: 0, right: spacing_half)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: spacing_half, bottom: 0, right: -spacing_half)
            }
        case .right:
            let titleWidth = self.titleLabel?.frame.size.width ?? 0
            if self.contentHorizontalAlignment == .left {
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleWidth + spacing, bottom: 0, right: 0)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageSize.width, bottom: 0, right: 0)
            }
            else if self.contentHorizontalAlignment == .right {
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -titleWidth)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: imageSize.width + spacing)
            }
            else {
                let imageOffset = titleWidth + 0.5 * spacing
                let titleOffset = imageSize.width + 0.5 * spacing
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: imageOffset, bottom: 0, right: -imageOffset)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -titleOffset, bottom: 0, right: titleOffset)
            }
        case .top:
            self.imageEdgeInsets = UIEdgeInsets.init(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        case .bottom:
            self.imageEdgeInsets = UIEdgeInsets.init(top: titleSize.height + spacing, left: 0, bottom: 0, right: -titleSize.width)
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageSize.width, bottom: imageSize.height + spacing, right: 0)
        }
    }
    
    /// 设置背景色
    /// - Parameters:
    ///   - color: 颜色
    ///   - state: 状态
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        if color != nil {
            let image = UIImage(color: color!)
            self.setBackgroundImage(image, for: state)
        }
        else {
            self.setBackgroundImage(nil, for: state)
        }
    }
}

private var GXBtnHitUIEdgeInsetsKey = 10
public extension UIButton {
    
    /// 位置枚举
    enum GXLocationMode {
        case top
        case bottom
        case left
        case right
    }
    
    /// 点击区域UIEdgeInsets
    var hitEdgeInsets: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &GXBtnHitUIEdgeInsetsKey) as? UIEdgeInsets
        }
        set {
            objc_setAssociatedObject(self, &GXBtnHitUIEdgeInsetsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Override
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard !self.isHidden || self.isEnabled || self.alpha > 0 else {
            return super.point(inside: point, with: event)
        }
        guard self.hitEdgeInsets != nil else {
            return super.point(inside: point, with: event)
        }
        guard self.hitEdgeInsets! != .zero else {
            return super.point(inside: point, with: event)
        }
        let hitFrame = self.bounds.inset(by: self.hitEdgeInsets!)
        return hitFrame.contains(point)
    }
}


