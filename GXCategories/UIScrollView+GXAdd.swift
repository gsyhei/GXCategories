//
//  UIScrollView+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/13.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    func scrollToTop(animated: Bool = false) {
        var offset = self.contentOffset
        offset.y = -self.contentInset.top
        let rect = CGRect(origin: offset, size: self.size)
        self.scrollRectToVisible(rect, animated: animated)
    }
    
    func scrollToBottom(animated: Bool = false) {
        var offset = self.contentOffset
        offset.y = self.contentSize.height - self.height + self.contentInset.bottom
        let rect = CGRect(origin: offset, size: self.size)
        self.scrollRectToVisible(rect, animated: animated)
    }
    
    func scrollToLeft(animated: Bool = false) {
        var offset = self.contentOffset
        offset.x = -self.contentInset.left
        let rect = CGRect(origin: offset, size: self.size)
        self.scrollRectToVisible(rect, animated: animated)
    }
    
    func scrollToRight(animated: Bool = false) {
        var offset = self.contentOffset
        offset.x = self.contentSize.width - self.width + self.contentInset.right
        let rect = CGRect(origin: offset, size: self.size)
        self.scrollRectToVisible(rect, animated: animated)
    }
}
