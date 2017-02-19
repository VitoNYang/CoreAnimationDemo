//
//  CATransformLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/17.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CATransformLayerViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    let ninetyDegrees = CGFloat(M_PI_2)
    let fortyDegress = CGFloat(M_PI_4)
    var isAddCube = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isAddCube {
            isAddCube = true
            var pt = CATransform3DIdentity
            pt.m34 = -1.0 / 500
            containerView.layer.sublayerTransform = pt
            
            var ct1 = CATransform3DIdentity
            ct1 = CATransform3DTranslate(ct1, -100, 0, 0)
            let cube1 = self.cube(with: ct1)
            containerView.layer.addSublayer(cube1)
            
            var ct2 = CATransform3DIdentity
            ct2 = CATransform3DTranslate(ct2, 100, 0, 0)
            ct2 = CATransform3DRotate(ct2, -fortyDegress, 0, 1, 0)
            ct2 = CATransform3DRotate(ct2, -fortyDegress, 1, 0, 0)
            let cube2 = self.cube(with: ct2)
            containerView.layer.addSublayer(cube2)
        }
    }
    
    func face(with frame: CGRect, transform: CATransform3D) -> CALayer{
        let face = CALayer()
        
        face.frame = frame
        
        face.backgroundColor = UIColor.randomColor.cgColor
        
        face.transform = transform
        
        return face
    }
    
    func cube(with transform: CATransform3D) -> CALayer{
        let cube = CATransformLayer()
        
        let faceWidth: CGFloat = 100
        let halfFaceWidth = faceWidth * 0.5
        let faceRect = CGRect(x: -halfFaceWidth, y: -halfFaceWidth, width: faceWidth, height: faceWidth)
        
        // face 1, 前
        var ct = CATransform3DMakeTranslation(0, 0, halfFaceWidth)
        var face = self.face(with: faceRect, transform: ct)
        cube.addSublayer(face)
        
        // face 2, 右
        ct = CATransform3DMakeTranslation(halfFaceWidth, 0, 0)
        ct = CATransform3DRotate(ct, ninetyDegrees, 0, 1, 0)
        face = self.face(with: faceRect, transform: ct)
        cube.addSublayer(face)
        
        // face 3, 上
        ct = CATransform3DMakeTranslation(0, -halfFaceWidth, 0)
        ct = CATransform3DRotate(ct, -ninetyDegrees, 1, 0, 0)
        face = self.face(with: faceRect, transform: ct)
        cube.addSublayer(face)
        
        // face 4, 左
        ct = CATransform3DMakeTranslation(-halfFaceWidth, 0, 0)
        ct = CATransform3DRotate(ct, -ninetyDegrees, 0, 1, 0)
        face = self.face(with: faceRect, transform: ct)
        cube.addSublayer(face)
        
        // face 5, 后
        ct = CATransform3DMakeTranslation(0, 0, -halfFaceWidth)
        ct = CATransform3DRotate(ct, CGFloat(M_PI), 0, 1, 0)
        face = self.face(with: faceRect, transform: ct)
        cube.addSublayer(face)
        
        // face 6, 下
        ct = CATransform3DMakeTranslation(0, halfFaceWidth, 0)
        ct = CATransform3DRotate(ct, ninetyDegrees, 1, 0, 0)
        face = self.face(with: faceRect, transform: ct)
        cube.addSublayer(face)
        
        let containerSize = containerView.bounds.size
        cube.position = CGPoint(x: containerSize.width * 0.5, y: containerSize.height * 0.5)
        
        cube.transform = transform
        
        return cube
    }

}
