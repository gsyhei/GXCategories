//
//  ViewController.swift
//  GXCategoriesSample
//
//  Created by Gin on 2020/11/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.button1.imageLocationAdjust(model: .top, spacing: 14.0)
        self.button2.imageLocationAdjust(model: .left, spacing: 14.0)
        self.button3.imageLocationAdjust(model: .right, spacing: 14.0)
        self.button4.imageLocationAdjust(model: .bottom, spacing: 14.0)
        
        self.button4.setTitle(GXLSTR("按钮"), for: .normal)
    }
    
    @IBAction func button1Clicked(_ sender: Any?) {
        GXBundle.userLanguage = "zh-Hans"
        self.button4.setTitle(GXLSTR("按钮"), for: .normal)
        NSLog("当前国际化%@：%@", GXBundle.userLanguage, GXLSTR("按钮"))
    }
    
    @IBAction func button2Clicked(_ sender: Any?) {
        GXBundle.userLanguage = "zh-Hant"
        self.button4.setTitle(GXLSTR("按钮"), for: .normal)
        NSLog("当前国际化%@：%@", GXBundle.userLanguage, GXLSTR("按钮"))
    }
    
    @IBAction func button3Clicked(_ sender: Any?) {
        GXBundle.userLanguage = "en"
        self.button4.setTitle(GXLSTR("按钮"), for: .normal)
        NSLog("当前国际化%@：%@", GXBundle.userLanguage, GXLSTR("按钮"))
    }
    
    @IBAction func button4Clicked(_ sender: Any?) {
        
    }

}



