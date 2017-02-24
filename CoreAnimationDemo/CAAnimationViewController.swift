//
//  CAAnimationViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/24.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CAAnimationViewController: UIViewController {
    
    lazy var animationLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.randomColor.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let button = UIButton(type: .system)
        button.setTitle("Touch Me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeColor(sender:)), for: .touchUpInside)
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layer.addSublayer(animationLayer)
        animationLayer.position = view.center
        
    }
    
    @IBAction func changeColor(sender: UIButton) {
        let animation = CABasicAnimation()
        animation.keyPath = "backgroundColor"
        animation.toValue = UIColor.randomColor.cgColor
        animation.delegate = self
//        let animation = CAKeyframeAnimation()
//        animation.keyPath = "backgroundColor"
//        animation.duration = 2.0
//        animation.values = [animationLayer.backgroundColor!,
//                            UIColor.randomColor.cgColor,
//                            UIColor.randomColor.cgColor,
//                            UIColor.randomColor.cgColor,
//                            UIColor.randomColor.cgColor,
//                            animationLayer.backgroundColor!]
        animationLayer.add(animation, forKey: nil)
    }

}

extension CAAnimationViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let baseAnimation = anim as? CABasicAnimation else {
            return
        }
//        print("animationDidStop")
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//        if let keyPath = baseAnimation.keyPath, let toValue = baseAnimation.toValue {
//            animationLayer.setValue(toValue, forKey: keyPath)
//        }
//        CATransaction.commit()
    }
}
