//
//  CAShapeLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/16.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CAShapeLayerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cornerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // create path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 175, y: 100))
        
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 25, startAngle: 0, endAngle: 2.0 * CGFloat.pi, clockwise: true)
        path.move(to: CGPoint(x: 150, y: 125))
        path.addLine(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 125, y: 225))
        path.move(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 175, y: 225))
        path.move(to: CGPoint(x: 100, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 150))
        
        // create shape layer
        let shapeLayer = CAShapeLayer()
        // 边框颜色
        shapeLayer.strokeColor = UIColor.red.cgColor
        // 填充颜色
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 5
        // 线条结尾处理
        shapeLayer.lineJoin = kCALineJoinRound
        // 线条拐弯处处理
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.path = path.cgPath
        // add it to containerView
        containerView.layer.addSublayer(shapeLayer)
        
        let rect = cornerView.bounds
        let cornerRadii = 150 * 0.5
        let cornerPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [UIRectCorner.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let cornerLayer = CAShapeLayer()
//        cornerLayer.strokeColor = UIColor.red.cgColor
//        cornerLayer.lineWidth = 10
//        cornerLayer.lineJoin = kCALineJoinRound
//        cornerLayer.lineCap = kCALineCapRound
        cornerLayer.path = cornerPath.cgPath
        cornerView.layer.mask = cornerLayer
//        cornerLayer.contents = cornerView
    }
}
