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
    
    @IBOutlet weak var cp1XTF: UITextField! {
        didSet {
            cp1XTF.addTarget(self, action: #selector(valueDidChange(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var cp1YTF: UITextField! {
        didSet {
            cp1YTF.addTarget(self, action: #selector(valueDidChange(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var cp2XTF: UITextField! {
        didSet {
            cp2XTF.addTarget(self, action: #selector(valueDidChange(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var cp2YTF: UITextField! {
        didSet {
            cp2YTF.addTarget(self, action: #selector(valueDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var animationContainerView: UIView!
    lazy var animationLayer: CALayer = {
        $0.backgroundColor = UIColor.randomColor.cgColor
        $0.cornerRadius = 25
        return $0
    }(CALayer())
    
    var timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 坐标系翻转
        bezierPathView.shapeLayer.isGeometryFlipped = true
        bezierPathView.shapeLayer.lineWidth = 4
        bezierPathView.shapeLayer.strokeColor = UIColor.red.cgColor
        bezierPathView.shapeLayer.fillColor = UIColor.clear.cgColor
        
        animationContainerView.layer.addSublayer(animationLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBezierPathView()
        animationLayer.bounds = CGRect(x: 0, y: 0, width: animationContainerView.bounds.height, height: animationContainerView.bounds.height)
        animationLayer.position = CGPoint(x: animationLayer.bounds.width / 2, y: animationLayer.bounds.height / 2)
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
    
    /// 设置 bezier path view
    private func setupBezierPathView() {
        var timingFunction = mediaTimingFunction(from: segmentedControl.selectedSegmentIndex)
        if timingFunction == nil {
            timingFunction = CAMediaTimingFunction(controlPoints: cp1XTF.number, cp1YTF.number, cp2XTF.number, cp2YTF.number)
        }
        self.timingFunction = timingFunction!
        let controlPoints = getControlPoint(by: timingFunction!)
        bezierPathView.shapeLayer.path = bezierPath(from: controlPoints.0, controlPoint2: controlPoints.1)
    }
    
    @IBAction func segmentedControlValueDidChange(sender: UISegmentedControl) {
        setupBezierPathView()
    }
    @IBAction func animationAction(_ sender: UIButton) {
        let animation = CABasicAnimation()
        animation.keyPath = "position"
        animation.duration = 1
        animation.timingFunction = timingFunction
        animation.toValue = CGPoint(x: animationContainerView.bounds.width - animationContainerView.bounds.height / 2, y: animationLayer.bounds.height / 2)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animationLayer.add(animation, forKey: "positionAnimation")
    }
    
    @IBAction func valueDidChange(_ sender: UITextField) {
        // 如果没有选中 Custom 则不做处理
        if segmentedControl.selectedSegmentIndex != segmentedControl.numberOfSegments - 1 {
            return
        }
        setupBezierPathView()
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
