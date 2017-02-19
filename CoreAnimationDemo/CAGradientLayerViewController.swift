//
//  CAGradientLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/17.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CAGradientLayerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 创建渐变图层
        let layer = CAGradientLayer()
        // startPoint / endPoint 设置渐变的起始和结束点，用于确定渐变的方向
        // 左上角为{0, 0}, 右下角为{0, 0}
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        
        layer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        
        layer.frame = containerView.bounds
        
        containerView.layer.addSublayer(layer)
    }
}
