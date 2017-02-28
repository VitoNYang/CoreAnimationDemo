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
        layer.path = self.bezierPath.cgPath
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        return layer
    }()
    
    lazy var animationLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.blue.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.layer.addSublayer(shapeLayer)
        self.view.layer.addSublayer(animationLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.shapeLayer.position = self.view.center
//        self.animationLayer.position = CGPoint(x: shapeLayer.frame.minX, y:  shapeLayer.frame.midY)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.path = self.bezierPath.cgPath
            keyframeAnimation.keyPath = "position"
            keyframeAnimation.duration = 4
            // 让layer 根据路径旋转适合的角度
            keyframeAnimation.rotationMode = kCAAnimationRotateAuto
            self.animationLayer.add(keyframeAnimation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4, execute: { 
                self.animationLayer.position = self.view.center
                let basicAnimation = CABasicAnimation()
                basicAnimation.keyPath = "transform"
                basicAnimation.duration = 2
                basicAnimation.byValue = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1)
                self.animationLayer.add(basicAnimation, forKey: nil)
            })
        }
    }
}
