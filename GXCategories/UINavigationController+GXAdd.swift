//
//  UINavigationController+GXAdd.swift
//  GXCategoriesSample
//
//  Created by Gin on 2022/8/23.
//

import Foundation
import UIKit

public extension UINavigationController {

    /// pop到目标vcType
    /// - Parameters:
    ///   - vcType: 目标vcType
    ///   - animated: 是否动画
    @discardableResult
    func popToViewController(vcType: UIViewController.Type, animated: Bool) -> [UIViewController]? {
        for vc in self.viewControllers {
            if (vc.isMember(of: vcType)) {
                return self.popToViewController(vc, animated: animated)
            }
        }
        return nil
    }
    
    /// push到目标vc，视图控制器堆栈移除当前
    /// - Parameters:
    ///   - vc: push目标vc
    ///   - animated: 是否动画
    func pushByReturnToViewController(vc: UIViewController, animated: Bool) {
        var vcs: [UIViewController] = self.viewControllers
        vcs.removeLast()
        vcs.append(vc)
        self.setViewControllers(vcs, animated: animated)
    }
    
    /// push到目标vc，视图控制器堆栈只保留root
    /// - Parameters:
    ///   - vc: push目标vc
    ///   - animated: 是否动画
    func pushByRootToViewController(vc: UIViewController, animated: Bool) {
        var vcs: [UIViewController] = []
        if let rootVC = self.viewControllers.first {
            vcs.append(rootVC)
        }
        vcs.append(vc)
        self.setViewControllers(vcs, animated: animated)
    }

}

