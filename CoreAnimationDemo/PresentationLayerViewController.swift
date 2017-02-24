//
//  PresentationLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/24.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 通过layer的presentation() 可以访问到当前的呈现图层
 */
class PresentationLayerViewController: UIViewController {
    
    lazy var colorLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.randomColor.cgColor
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.addSublayer(colorLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        colorLayer.position = view.center
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: view) {
            
            // 这里需要用presentation来做 hitTest
            if colorLayer.presentation()?.hitTest(point) != nil {
                colorLayer.backgroundColor = UIColor.randomColor.cgColor
            } else {
                CATransaction.begin()
                CATransaction.setAnimationDuration(5.0)
                colorLayer.position = point
                CATransaction.commit()
            }
        }
    }

}
