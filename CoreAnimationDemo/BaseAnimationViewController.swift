//
//  BaseAnimationViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/23.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 CALayer 隐式动画
 1，先判断layer有没有delegate, 并且是否实现了 CALayerDelegate 指定的
 func action(for layer: CALayer, forKey event: String) 方法，如果有，
 直接调用并返回结果。
 2，如果没有delegate, 或者delegate 没有实现 func action(for layer: CALayer, forKey event: String) 方法，
 layer接着检查包含属性名称对应行为映射的actions 字典。
 3，如果actions字典么有包含对应的属性，那么layer接着在它的style字典接着搜索属性名。
 4，最后，如果在style里面也找不到对应的行为，那么layer将会直接调用定义了每个属性的标准行为
 defaultAction(forKey event: String)方法
 
 
 UIView 关联的layer 禁用了隐式动画， 要对这种layer做动画可以使用UIView 的动画函数
 或者是继承UIView， 并覆盖func action(for layer: CALayer, forKey event: String) 方法
 或者直接创建一个显示动画
 */
class BaseAnimationViewController: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    
    var animationLayer: CALayer? {
        didSet {
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            animationLayer?.actions = ["backgroundColor":transition]
        }
    }

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
        CATransaction.setAnimationDuration(1.0)
        /*CATransaction.setCompletionBlock {
            if let transform = self.animationLayer?.affineTransform() {
                self.animationLayer?.setAffineTransform(transform.rotated(by: CGFloat.pi / 4))
            }
            
//            if var transform = self.animationLayer?.transform {
//                transform = CATransform3DRotate(transform, CGFloat.pi / 4, 0, 0, 1)
//                self.animationLayer?.transform = transform
//            }
        }*/
        animationLayer?.backgroundColor = UIColor.randomColor.cgColor
        animationLayer?.cornerRadius = CGFloat(arc4random() % UInt32(min(animationView.bounds.width, animationView.bounds.height))) / 2
        CATransaction.commit()

        
        // 可验证当属性在动画block 之外，UIView直接返回nil 来禁止动画
        // 如果在block 之内，根据动画具体类型返回对应的属性
        print("Outside > \(animationView.layer.action(forKey: "backgroundColor"))")
        // 开始动画
        UIView.beginAnimations(nil, context: nil)
        print("Inside > \(animationView.layer.action(forKey: "backgroundColor"))")
        // 提交动画
        UIView.commitAnimations()

    }
}
//
//extension BaseAnimationViewController: CALayerDelegate {
//    func action(for layer: CALayer, forKey event: String) -> CAAction? {
//        layer.action(forKey: <#T##String#>)
//    }
//}
