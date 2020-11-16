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
    }

}

