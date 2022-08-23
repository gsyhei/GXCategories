//
//  UIViewController+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/13.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension UIViewController {

    class func xibViewController() -> Self {
        return self.init(nibName: self.className(), bundle: nil)
    }
    
    func addBackBarButtonItem(imageNamed: String, action: Selector = #selector(backBarButtonItemTapped)) {
        let normalImage = UIImage(named: imageNamed)?.withRenderingMode(.automatic)
        let leftBarButtonItem = UIBarButtonItem(image: normalImage, style: .plain, target: self, action: action)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func addBackBarButtonItem(image: UIImage, action: Selector = #selector(backBarButtonItemTapped)) {
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
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
