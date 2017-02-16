//
//  MaskViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/15.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit
import CoreMotion

/*
 layer.mask 可是设置layer的蒙版
 */

class MaskViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    weak var maskLayer: CALayer!
    
    lazy var motionManager: CMMotionManager = {
        let manager = CMMotionManager()
//        manager.gyroUpdateInterval = 1
//        manager.deviceMotionUpdateInterval = 1
        manager.accelerometerUpdateInterval = 1 / 60.0
        return manager
    }()
    
    lazy var motionView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.view.addSubview(view)
        view.center = self.view.center
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let maskLayer = CALayer()
        maskLayer.contents = #imageLiteral(resourceName: "Star 1").cgImage
        maskLayer.frame = CGRect(x: view.center.x - 50, y: view.center.y - 50, width: 100, height: 100)
        imageView.layer.mask = maskLayer
        self.maskLayer = maskLayer

    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        setupMaskPosition(touches: touches)
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        setupMaskPosition(touches: touches)
//    }
//    
//    func setupMaskPosition(touches: Set<UITouch>) {
//        guard let touch = touches.first else {
//            return
//        }
//        let point = touch.location(in: view)
//        maskLayer.position = point
    //    }
    
    
    //============================================
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        motionManager.stopGyroUpdates()
        motionManager.stopAccelerometerUpdates()
        motionManager.stopDeviceMotionUpdates()
        motionManager.stopMagnetometerUpdates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            self.updateLayer(accelerometerData: data!)
        }
        //        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (motion, error) in
        //            guard let deviceMotion = motion else {
        //                print("error >>> \(error)")
        //                return
        //            }
        //            self.updateLayer(motion: deviceMotion)
        //        }
        //        motionManager.startGyroUpdates(to: OperationQueue.current!) { (gyroData, error) in
        //            guard let data = gyroData else {
        //                return
        //            }
        //            self.updateLayer(data: data)
        //        }
    }
    
    func updateLayer(accelerometerData: CMAccelerometerData) {
        let x = accelerometerData.acceleration.x
        let y = accelerometerData.acceleration.y
        let z = accelerometerData.acceleration.z
        speedX += CGFloat(x)
        speedY += CGFloat(y)
        print("x = \(x), y = \(y), z = \(z)")
        motionView.center -= CGPoint(x: speedX, y: speedY)
    }
    
    func updateLayer(data: CMGyroData) {
        let x = data.rotationRate.x
        let y = data.rotationRate.y
        let z = data.rotationRate.z
        print("x = \(x), y = \(y), z = \(z)")
    }
    
    var speedX: CGFloat = 0
    var speedY: CGFloat = 0
    
    func updateLayer(motion: CMDeviceMotion) {
        let x = motion.userAcceleration.x
        let y = motion.userAcceleration.y
        let z = motion.userAcceleration.z
        speedX += CGFloat(x)
        speedY += CGFloat(y)
        print("x = \(x), y = \(y), z = \(z)")
        motionView.center -= CGPoint(x: speedX, y: speedY)
    }

}

func -=( lhs: inout CGPoint, rhs: CGPoint) {
    lhs = CGPoint(x: lhs.x + rhs.x, y: lhs.y - rhs.y)
}
