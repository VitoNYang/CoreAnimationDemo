//
//  ThreeDViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/16.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit
import GLKit

class ThreeDViewController: UIViewController {

    @IBOutlet var subviews: [UIView]!
    @IBOutlet weak var containerView: UIView!
    
    let LIGHT_DIRECTION: (Float, Float, Float) = (0, 1, -0.5)
    let AMBIENT_LIGHT: Float = 0.5
    
    var angel = CGFloat(-M_PI_4)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(pan:)))
        containerView.addGestureRecognizer(panGesture)
    }
    
    func handlePan(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: pan.view)
        let angel1 = angel + translation.x / 30
        let angel2 = angel - translation.y / 30
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500
        perspective = CATransform3DRotate(perspective, angel1, 0, 1, 0)
        perspective = CATransform3DRotate(perspective, angel2, 1, 0, 0)
        containerView.layer.sublayerTransform = perspective
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    func setup() {
        // 设置container 的sublayer transform, 确保都是同一个灭点
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500
        perspective = CATransform3DRotate(perspective, -(CGFloat)(M_PI_4), 1, 0, 0)
        perspective = CATransform3DRotate(perspective, -(CGFloat)(M_PI_4), 0, 1, 0)
        containerView.layer.sublayerTransform = perspective
        
        // 添加第一面, 前
        var transform = CATransform3DMakeTranslation(0, 0, 100)
        add(face: 0, with: transform)
        
        // 添加第二面, 右
        // 先平移
        transform = CATransform3DMakeTranslation(100, 0, 0)
        // 再旋转90度
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 0, 1, 0)
        add(face: 1, with: transform)
        
            // 添加第三面, 后
            transform = CATransform3DMakeTranslation(0, 0, -100)
        transform = CATransform3DRotate(transform, CGFloat(M_PI), 0, 1, 0)
        add(face: 2, with: transform)
        
        // 添加第四面, 左
        transform = CATransform3DMakeTranslation(-100, 0, 0)
        transform = CATransform3DRotate(transform, -(CGFloat)(M_PI_2), 0, 1, 0)
        add(face: 3, with: transform)
        
        // 添加第五面, 上
        transform = CATransform3DMakeTranslation(0, -100, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 1, 0, 0)
        add(face: 4, with: transform)
        
        // 添加第六面, 下
        transform = CATransform3DMakeTranslation(0, 100, 0)
        transform = CATransform3DRotate(transform, -(CGFloat)(M_PI_2), 1, 0, 0)
        add(face: 5, with: transform)
    }
    
    func add(face index: Int, with transform: CATransform3D) {
        // 获取对应的面，并添加到containerView中
        let face = subviews[index]
        containerView.addSubview(face)
        // 把面放置到containerView中间
        let containerSize = containerView.bounds.size
        face.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
//        face.layer.borderColor = UIColor.black.cgColor
//        face.layer.borderWidth = 1
        face.center = CGPoint(x: containerSize.width * 0.5, y: containerSize.height * 0.5)
        face.setNeedsUpdateConstraints()
        face.updateConstraintsIfNeeded()
        // 设置transform
        face.layer.transform = transform
        // apply lighting
        applyLighting(to: face.layer)
    }
    
    // 添加阴影
    func applyLighting(to face: CALayer) {
        // add lighting layer
        let layer = CALayer()
        layer.frame = face.bounds
        face.addSublayer(layer)
        
        // covert the face transform to matrix
        let transform = face.transform
        let matrix4 = transform3DToMatrix4(transform: transform)
        let matrix3 = GLKMatrix4GetMatrix3(matrix4)
        // get face normal
        var normal = GLKVector3(v: (0, 0, 1))
        normal = GLKMatrix3MultiplyVector3(matrix3, normal)
        normal = GLKVector3Normalize(normal)
        // get dot product with light direction
        let light = GLKVector3Normalize(GLKVector3(v: LIGHT_DIRECTION))
        
        let dotProduct = GLKVector3DotProduct(light, normal)
        // set lighting layer opacity
        let shadow = 1 + dotProduct - AMBIENT_LIGHT
        let color = UIColor(white: 0, alpha: CGFloat(shadow))
        layer.backgroundColor = color.cgColor
    }

    @IBAction func tap(_ sender: UIButton) {
        print("5")
    }
}

func transform3DToMatrix4(transform: CATransform3D) -> GLKMatrix4{
    return GLKMatrix4(m: (Float(transform.m11),
                   Float(transform.m12),
                   Float(transform.m13),
                   Float(transform.m14),
                   Float(transform.m21),
                   Float(transform.m22),
                   Float(transform.m23),
                   Float(transform.m24),
                   Float(transform.m31),
                   Float(transform.m32),
                   Float(transform.m33),
                   Float(transform.m34),
                   Float(transform.m41),
                   Float(transform.m42),
                   Float(transform.m43),
                   Float(transform.m44)))
}
