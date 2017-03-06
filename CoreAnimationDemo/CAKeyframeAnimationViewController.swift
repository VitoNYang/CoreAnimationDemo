//
//  CAKeyframeAnimationViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/24.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 CAKeyframeAnimation
    rotationMode : 动画过程中，layer的rotation 模式, 如果设成kCAAnimationRotateAuto 则会跟随动画方向自动旋转
    path : 动画的路径
 CAAnimationGroup : 可将多个动画组合在一起，duration 是动画的时间，应等于最长时间动画的时长， animations 是动画 列表
 */
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
        layer.bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
        return layer
    }()
    
    lazy var animationLayer: CALayer = {
        let layer = CALayer()
//        layer.backgroundColor = UIColor.blue.cgColor
        layer.contents = #imageLiteral(resourceName: "Star 1").cgImage
        layer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        containerView.layer.addSublayer(shapeLayer)
        containerView.layer.addSublayer(animationLayer)
        
        animationLayer.position = CGPoint(x: 0, y: 150)
        shapeLayer.position = CGPoint(x: 150, y: 150)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    /*
     duration 和 repeatCount 默认为0 , 不代表动画时长为0秒或0次, 这里的0仅仅代表了默认, 也就是0.25和一次
     动画时长=duration * repleatCount
     repleatCount 和 repeatDuration 只能设置其中一个，都设置的话会引起冲突
     */
    @IBAction func keyframeAnimationAction(_ sender: UIButton) {
        let keyframeAnimation = CAKeyframeAnimation()
        keyframeAnimation.path = self.bezierPath.cgPath
        keyframeAnimation.keyPath = "position"
        keyframeAnimation.duration = 2 // 单次动画的时间
        keyframeAnimation.repeatCount = 1 // 重复次数
        keyframeAnimation.autoreverses = true
        // 让layer 根据路径旋转适合的角度
        keyframeAnimation.rotationMode = kCAAnimationRotateAuto
        self.animationLayer.add(keyframeAnimation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4, execute: {
            let basicAnimation = CABasicAnimation()
            basicAnimation.keyPath = "transform.rotation"
            basicAnimation.duration = 2
            basicAnimation.byValue = CGFloat.pi * 2
            self.animationLayer.add(basicAnimation, forKey: nil)
        })
    }
    @IBAction func animationGroupAction(_ sender: UIButton) {
        // keyframe animation
        let keyframeAnimation = CAKeyframeAnimation()
        keyframeAnimation.path = self.bezierPath.cgPath
        keyframeAnimation.keyPath = "position"
        keyframeAnimation.duration = 4
        // 让layer 根据路径旋转适合的角度
        keyframeAnimation.rotationMode = kCAAnimationRotateAuto
        
        // change background color
        let basicAnimation = CABasicAnimation()
        basicAnimation.keyPath = "backgroundColor"
        basicAnimation.duration = 4
        basicAnimation.toValue = UIColor.red.cgColor
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 4
        groupAnimation.animations = [keyframeAnimation, basicAnimation]
        animationLayer.add(groupAnimation, forKey: nil)
    }
}
