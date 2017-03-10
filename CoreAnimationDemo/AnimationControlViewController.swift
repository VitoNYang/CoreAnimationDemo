//
//  AnimationControlViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/10.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class AnimationControlViewController: UIViewController {

    @IBOutlet weak var doorView: UIView!
    
    var doorLayer: CALayer {
        return doorView.layer
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandle(gestureRecognizer:)))
        view.addGestureRecognizer(panGesture)
        
        let baseAnimation = CABasicAnimation()
        baseAnimation.keyPath = "transform.rotation.y"
        baseAnimation.toValue = -CGFloat.pi / 2
        baseAnimation.duration = 1
        
        doorLayer.anchorPoint = CGPoint(x: 0, y: 0.5)
        doorLayer.speed = 0
        doorLayer.cornerRadius = 10
        
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        view.layer.sublayerTransform = transform
        
        
        doorLayer.add(baseAnimation, forKey: "rotation")
    }
    
    func panHandle(gestureRecognizer: UIPanGestureRecognizer) {
        var x = gestureRecognizer.translation(in: view).x
        x /= 200
        var timeOffset = doorLayer.timeOffset
        timeOffset = min(0.999, max(0.0, timeOffset - CFTimeInterval(x)))
        doorLayer.timeOffset = timeOffset
        
        gestureRecognizer.setTranslation(.zero, in: view)
    }

}
