//
//  CAEmitterLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/20.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
    CAEmitterCell 的属性可以分为三种
        1. 某一属性的初始值
           e.g. color属性指定了一个可以混合图片内容颜色的混合色
        2. 某一属性的变化范围
           e.g. emissionRange 设置发射范围
        3. 指定值在时间线上的变化
           e.g. alphaSpeed 透明度的变化
 */
class CAEmitterLayerViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 创建发射器
        let emitter = CAEmitterLayer()
        emitter.frame = containerView.bounds
        containerView.layer.addSublayer(emitter)
        
        // 配置发射器
        /*
         renderMode : 混合模式
             kCAEmitterLayerUnordered
             kCAEmitterLayerOldestFirst
             kCAEmitterLayerOldestLast
             kCAEmitterLayerBackToFront
             kCAEmitterLayerAdditive 重叠
         */
        
        emitter.renderMode = kCAEmitterLayerAdditive
        // 发射点的位置
        emitter.emitterPosition = CGPoint(x: emitter.frame.width * 0.5, y: emitter.frame.height * 0.5)
        
        // 创建发射模板
        let cell = CAEmitterCell()
        
        cell.contents = #imageLiteral(resourceName: "star").cgImage
        
        // 每秒生成粒子的个数, 必须要设置
        cell.birthRate = 150
        
        // 粒子存活的时间
        cell.lifetime = 5.0
        
        cell.color = UIColor(red: 1, green: 0.5, blue: 0.1, alpha: 1).cgColor
        
        // 粒子消逝的速度, 每秒透明度减少0.4
        cell.alphaSpeed = -0.3
        
        // 粒子运动的速度均值
        cell.velocity = 50
        
        // 粒子运动的速度扰动范围
        cell.velocityRange = 90
        
        // 发射角度, 这里设置了可以从360度任意位置发射出来
        cell.emissionRange = CGFloat(M_PI * 2)
        
        emitter.emitterCells = [cell]
    }

}
