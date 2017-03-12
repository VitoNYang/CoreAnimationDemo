//
//  CAMediaTimingFunctionBezierPathViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/3/12.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CAMediaTimingFunctionBezierPathViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var bezierPathView: BezierPathView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 坐标系翻转
        bezierPathView.shapeLayer.isGeometryFlipped = true
        bezierPathView.shapeLayer.lineWidth = 4
        bezierPathView.shapeLayer.strokeColor = UIColor.red.cgColor
        bezierPathView.shapeLayer.fillColor = UIColor.clear.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let timingFunction = mediaTimingFunction(from: segmentedControl.selectedSegmentIndex)
        let controlPoints = getControlPoint(by: timingFunction)
        bezierPathView.shapeLayer.path = bezierPath(from: controlPoints.0, controlPoint2: controlPoints.1)
    }
    
    /// 根据控制点生成 bezier 曲线
    private func bezierPath(from controlPoint1: CGPoint, controlPoint2: CGPoint) -> CGPath{
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.addCurve(to: .init(x: 1, y: 1), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        bezierPath.apply(CGAffineTransform(scaleX: bezierPathView.bounds.width, y: bezierPathView.bounds.width))
        return bezierPath.cgPath
    }
    
    /// 根据CAMediaTimingFunction 获取控制点
    private func getControlPoint(by timingFunction: CAMediaTimingFunction) -> (CGPoint, CGPoint){
        var controlPoint1: [Float] = [0,0]
        var controlPoint2: [Float] = [0,0]
        timingFunction.getControlPoint(at: 1, values: &controlPoint1)
        timingFunction.getControlPoint(at: 2, values: &controlPoint2)
        let point1 = CGPoint(x: CGFloat(controlPoint1[0]), y: CGFloat(controlPoint1[1]))
        let point2 = CGPoint(x: CGFloat(controlPoint2[0]), y: CGFloat(controlPoint2[1]))
        return (point1, point2)
    }
    
    @IBAction func segmentedControlValueDidChange(sender: UISegmentedControl) {
        let timingFunction = mediaTimingFunction(from: sender.selectedSegmentIndex)
        let controlPoints = getControlPoint(by: timingFunction)
        bezierPathView.shapeLayer.path = bezierPath(from: controlPoints.0, controlPoint2: controlPoints.1)
    }
}

class BezierPathView: UIView {
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
}
