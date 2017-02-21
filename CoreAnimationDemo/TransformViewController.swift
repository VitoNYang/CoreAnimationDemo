//
//  TransformViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/16.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 旋转的变换函数使用弧度而不是角度作为单位
 
 CGAffineTransform // 二维
 identity : [ 1 0 0 1 0 0 ]
 
 
 ========================
 
 CATransform3D     // 三维
 CATransform3DIdentity : [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 (0) 1] 
    m34用来做透视， 默认值为0, 可以 m34为 -1.0 / d 来应用透视效果，d 代表
    想象中视角相机和屏幕之间的距离，以像素为单位，通常为500-1000
 sublayerTransform: 可以设置统一的灭点
 
 */
class TransformViewController: UIViewController {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var transform3DImageView: UIImageView!
    
    @IBOutlet var subViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 创建一个新的transform
        var transform = CGAffineTransform.identity
        // 缩小50%
        transform = transform.scaledBy(x: 0.5, y: 0.5)
        // 选择35度
        transform = transform.rotated(by: CGFloat(degreesToRadians(x: 35)))
        // 横向平移 200 points
        transform = transform.translatedBy(x: 200, y: 0)
        layerView.layer.setAffineTransform(transform)
        
        for (index, subview) in subViews.enumerated() {
            var x: CGFloat = 0
            var y: CGFloat = 0
            switch index {
            case 0:
                x = -1
            case 1:
                y = 1
            case 2:
                y = -1
            case 3:
                x = 1
            default:
                break
            }
            let transform3D = CATransform3DMakeRotation(CGFloat(degreesToRadians(x: 60)), x, y, 0)
            subview.layer.transform = transform3D
        }
        
        // 设置sublayerTransform
        var transform3D = CATransform3DIdentity
        transform3D.m34 = -1.0 / 500
        layerView.layer.sublayerTransform = transform3D
        
        transform3DImageView.layer.isDoubleSided = false
    }
    
    @IBAction func valueDidChanged(_ sender: UISlider) {
        let value = sender.value
        var transform3D = CATransform3DIdentity
        // 设置透视
        transform3D.m34 = -1.0 / 1000
        switch sender.tag {
        case 1:
            print("x")
            transform3D = CATransform3DRotate(transform3D, degreesToRadians(x: CGFloat(value)), 1, 0, 0)
        case 2:
            print("y")
            transform3D = CATransform3DRotate(transform3D, degreesToRadians(x: CGFloat(value)), 0, 1, 0)
        case 3:
            print("z")
            transform3D = CATransform3DRotate(transform3D, degreesToRadians(x: CGFloat(value)), 0, 0, 1)
        default:
            break
        }
        transform3DImageView.layer.transform = transform3D
    }

}

// 角度转弧度
func degreesToRadians(x: CGFloat) -> CGFloat{
    return x * CGFloat.pi / 180.0
}
