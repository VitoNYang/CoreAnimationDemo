//
//  StopAnimationViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/6.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class StopAnimationViewController: UIViewController {

    weak var animationLayer: CALayer?
    weak var startButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        button.addTarget(self, action: #selector(startOrStopAnimation(sender:)), for: .touchUpInside)
        startButton = button
        
        let openDoorButton = UIButton()
        openDoorButton.translatesAutoresizingMaskIntoConstraints = false
        openDoorButton.setTitle("Auto Animation", for: .normal)
        openDoorButton.setTitleColor(UIColor.gray, for: .normal)
        openDoorButton.addTarget(self, action: #selector(doorAnimation(sender:)), for: .touchUpInside)
        view.addSubview(openDoorButton)
        openDoorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openDoorButton.bottomAnchor.constraint(equalTo: button.topAnchor, constant: 10).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard animationLayer == nil else{
            return
        }
        
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 150, height: 300)
        layer.backgroundColor = UIColor.red.cgColor
        layer.position = view.center
        
        view.layer.addSublayer(layer)
        animationLayer = layer
    }
    
    func startOrStopAnimation(sender: UIButton) {
        animationLayer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        if sender.currentTitle == "Start" {
            sender.setTitle("Stop", for: .normal)
            
            let animation = CABasicAnimation()
            animation.keyPath = "transform.rotation"
            animation.duration = 2.0
            animation.byValue = CGFloat.pi * 2
            animation.delegate = self
            animationLayer?.add(animation, forKey: "rotationAnimation")
        } else {
            animationLayer?.removeAnimation(forKey: "rotationAnimation")
        }
    }
    
    func doorAnimation(sender: UIButton) {
        animationLayer?.anchorPoint = CGPoint(x: 0, y: 0.5)
        if sender.currentTitle == "Auto Animation" {
            sender.setTitle("Stop", for: .normal)
            
            
            var perspective = CATransform3DIdentity
            perspective.m34 = -1 / 500
            view.layer.sublayerTransform = perspective
            let animation = CABasicAnimation()
            animation.keyPath = "transform.rotation.y"
            animation.toValue = -CGFloat.pi / 2
            animation.duration = 1
            animation.repeatDuration = CFTimeInterval.infinity
            animation.autoreverses = true

            animationLayer?.add(animation, forKey: nil)
            
        } else {
            sender.setTitle("Auto Animation", for: .normal)
            animationLayer?.removeAllAnimations()
        }
    }
}

/*
 CALayer 可以通过removeAnimation(forKey:) / removeAllAnimations 删除一个或所有动画
 CAAnimationDelegate 中的func animationDidStop(_ anim: CAAnimation, finished flag: Bool) 
    flag 如果是true 说明Animation是自动完成的，如果是false的话说明是手动remove的
 */
extension StopAnimationViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("The animation stopped (finished : \(flag))")
        
        startButton?.setTitle("Start", for: .normal)
    }
}
