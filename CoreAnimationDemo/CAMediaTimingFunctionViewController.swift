//
//  CAMediaTimingFunctionViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/3/12.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 // 线性, 默认
 kCAMediaTimingFunctionLinear
 // 慢慢加速然后突然停止
 kCAMediaTimingFunctionEaseIn
 // 全速开始然后慢慢减速停止
 kCAMediaTimingFunctionEaseOut
 // 慢慢加速然后慢慢减速
 kCAMediaTimingFunctionEaseInEaseOut
 // 类似kCAMediaTimingFunctionEaseInEaseOut, 但加速与减速更慢
 kCAMediaTimingFunctionDefault
 */
class CAMediaTimingFunctionViewController: UIViewController {

    lazy var animationLayer: CALayer = {
        $0.backgroundColor = UIColor.red.cgColor
        $0.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        return $0
    }(CALayer())
    
    lazy var animationView: UIView = {
        $0.backgroundColor = .blue
        $0.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        return $0
    }(UIView())
    
    lazy var topPositon: CGPoint = {
        return CGPoint(x: self.view.center.x, y: 130)
    }()
    lazy var bottomPositon: CGPoint = {
        return CGPoint(x: self.view.center.x, y: self.view.bounds.maxY - 30)
    }()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* test layer timingFunction
        view.layer.addSublayer(animationLayer)
        animationLayer.position = topPositon
         */
        
        // test UIView timingFunction
        view.addSubview(animationView)
        animationView.center = topPositon
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        var position: CGPoint
        if let location = touches.first?.location(in: view) {
            position = location
        }else {
            position = bottomPositon
        }
        /* test layer timingFunction
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        CATransaction.setAnimationTimingFunction(mediaTimingFunction(from: segmentedControl.selectedSegmentIndex))
        
//        if animationLayer.position == topPositon {
//            animationLayer.position = bottomPositon
//        } else {
//            animationLayer.position = topPositon
//        }

        animationLayer.position = position

        CATransaction.commit()
         */
        
        // test UIView timingFunction
        UIView.animate(withDuration: 1.0, delay: 0, options: animationOption(from: segmentedControl.selectedSegmentIndex), animations: {
            self.animationView.center = position
        }, completion: nil)
    }
    
    func animationOption(from index: Int) -> UIViewAnimationOptions {
        var option: UIViewAnimationOptions
        switch index {
        case 0:
            option = .curveLinear
        case 1:
            option = .curveEaseIn
        case 2:
            option = .curveEaseOut
        case 3:
            option = .curveEaseInOut
        default:
            option = .curveEaseInOut
        }
        return option
    }
    

}

func mediaTimingFunction(from index: Int) -> CAMediaTimingFunction? {
    var timingFunctionName: String
    switch index {
    case 0:
        timingFunctionName = kCAMediaTimingFunctionLinear
    case 1:
        timingFunctionName = kCAMediaTimingFunctionEaseIn
    case 2:
        timingFunctionName = kCAMediaTimingFunctionEaseOut
    case 3:
        timingFunctionName = kCAMediaTimingFunctionEaseInEaseOut
    case 4:
        timingFunctionName = kCAMediaTimingFunctionDefault
    default:
        return nil
    }
    return CAMediaTimingFunction(name: timingFunctionName)
}
