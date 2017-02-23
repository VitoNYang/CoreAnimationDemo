//
//  BaseAnimationViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/23.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class BaseAnimationViewController: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    
    var animationLayer: CALayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if animationLayer == nil {
            animationLayer = CALayer()
            animationLayer?.frame = animationView.bounds
            animationView.layer.addSublayer(animationLayer!)
        }
    }
    
    @IBAction func animationAction(_ sender: UIButton) {
        CATransaction.begin()
//        CATransaction.setAnimationDuration(1.0)
        animationLayer?.backgroundColor = UIColor.randomColor.cgColor
        animationLayer?.cornerRadius = CGFloat(arc4random() % UInt32(min(animationView.bounds.width, animationView.bounds.height))) / 2
        CATransaction.commit()
    }
}
