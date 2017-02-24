//
//  CAKeyframeAnimationViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/24.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CAKeyframeAnimationViewController: UIViewController {

    lazy var bezierPath: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 150))
        path.addCurve(to: CGPoint(x: 300, y: 150), controlPoint1: CGPoint(x: 75, y: 0), controlPoint2: CGPoint(x: 220, y: 300))
        return path
    }()
    
    lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
