//
//  UIViewController+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/13.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    class func xibViewController<T: UIViewController>(type: T.Type = T.self) -> T {
        guard let viewController = self.init(nibName: self.className(), bundle: nil) as? T else {
            fatalError("The xib viewController of '\(self)' is not of class '\(type.self)'")
        }
        return viewController
    }
    
    func addBackBarButtonItem(imageNamed: String, action: Selector = #selector(backBarButtonItemTapped)) {
        let normalImage = UIImage(named: imageNamed)?.withRenderingMode(.automatic)
        let leftBarButtonItem = UIBarButtonItem(image: normalImage, style: .plain, target: self, action: action)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func popToViewController(vcType: UIViewController.Type, animated: Bool) {
        guard self.navigationController != nil else { return }
        for vc in self.navigationController!.viewControllers {
            if (vc.isMember(of: vcType)) {
                self.navigationController?.popToViewController(vc, animated: animated)
                return
            }
        }
    }
    
    func dismissToViewController(vcType: UIViewController.Type, animated: Bool, completion: (() -> Void)? = nil) {
        var vc: UIViewController = self
        while (vc.presentingViewController != nil && vc.presentingViewController!.isMember(of: vcType)) {
            vc = vc.presentingViewController!
        }
        return vc.dismiss(animated: animated, completion: completion)
    }
    
    func dismissRootViewController(animated: Bool, completion: (() -> Void)? = nil) {
        var vc: UIViewController = self
        while (vc.presentingViewController != nil) {
            vc = vc.presentingViewController!
        }
        return vc.dismiss(animated: animated, completion: completion)
    }
}

public extension UIViewController {
    @objc func backBarButtonItemTapped() {
        if (self.navigationController?.popViewController(animated: true) == nil) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
