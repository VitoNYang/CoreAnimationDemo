//
//  CAMediaTimingViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/9.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CAMediaTimingViewController: UIViewController {

    lazy var animationPath: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 150))
        path.addCurve(to: CGPoint(x: 300, y: 150), controlPoint1: CGPoint(x: 75, y: 300), controlPoint2: CGPoint(x: 225, y: 0))
        return path
    }()
    
    @IBOutlet weak var fillModeSegmented: UISegmentedControl!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var timeOffsetSlider: UISlider!
    weak var containerView: UIView?
    weak var pathLayer: CALayer?
    weak var animationLayer: CALayer?
    
    private func fillMode() -> String {
        switch fillModeSegmented.selectedSegmentIndex {
        case 0:
            return kCAFillModeForwards
        case 1:
            return kCAFillModeBackwards
        case 2:
            return kCAFillModeBoth
        default:
            return kCAFillModeRemoved
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let containerView = UIView()
        containerView.backgroundColor = .gray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        self.containerView = containerView
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let animationLayer = CAShapeLayer()
        animationLayer.path = animationPath.cgPath
        animationLayer.fillColor = UIColor.clear.cgColor
        animationLayer.strokeColor = UIColor.red.cgColor
        animationLayer.lineWidth = 2
        
        containerView.layer.addSublayer(animationLayer)
        self.pathLayer = animationLayer
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let center = containerView?.center , let bounds = containerView?.bounds else {
            return
        }
        pathLayer?.bounds = CGRect(x: 0, y: 0, width: 300, height: bounds.height)
        pathLayer?.position = center
        
        let animationLayer = CALayer()
        animationLayer.bounds = CGRect(origin: .zero, size: .init(width: 20, height: 20))
        animationLayer.backgroundColor = UIColor.blue.cgColor
        animationLayer.position = .init(x: 0, y: 150)
        
        pathLayer?.addSublayer(animationLayer)
        self.animationLayer = animationLayer
    }
    
    @IBAction func playAction(_ sender: UIButton) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.path = animationPath.cgPath
        animation.duration = 2
        animation.timeOffset = CFTimeInterval(timeOffsetSlider.value)
        animation.speed = speedSlider.value
        animation.rotationMode = kCAAnimationRotateAuto
        animation.isRemovedOnCompletion = false
        animation.fillMode = fillMode()
        
        animationLayer?.add(animation, forKey: "slide")
    }
    
    @IBAction func removeAnimation(_ sender: UIButton) {
        animationLayer?.removeAnimation(forKey: "slide")
    }

}
