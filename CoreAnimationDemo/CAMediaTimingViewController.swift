//
//  CAMediaTimingViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/9.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 当CAAnimation设置到Layer上面之后，就不能再修改它的属性了
 要暂停一个动画，可以设置layer的 speed 为 0， 如果 speed 大于1 动画快进，小于0 则动画倒退
 
 在 app delegate 中设置window 的 layer 的speed 加速减速可以调试所有动画的速度
 self.window.layer.speed = 100
 */
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
        animation.beginTime = CACurrentMediaTime() + 3
        // isRemovedOnCompletion 默认为true, 代表动画执行完毕后就从图层上移除，图形会
        // 恢复到动画执行前的状态。如果想让图层保持消失动画执行后的状态，那就设置为No，
        // 不过还要设置fillMode 为kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        // fillMode 决定当前对象在非active时间段的行为
        // kCAFillModeRemoved : 这个是默认值，就是当动画开始前和结束后，动画对 layer 没有影响，动画结束后， layer 会恢复到之前的状态
        // kCAFillModeForwards : 当动画结束后，layer 会一直保持着动画最后的状态
        // kCAFillModeBackwards : 当动画开始前，你只要把 layer 加入到一个动画中， layer 便立即进入
        // 动画的初始状态，并等待动画开始
        animation.fillMode = fillMode()
        
        animationLayer?.add(animation, forKey: "slide")
    }
    
    @IBAction func removeAnimation(_ sender: UIButton) {
        animationLayer?.removeAnimation(forKey: "slide")
    }

}
