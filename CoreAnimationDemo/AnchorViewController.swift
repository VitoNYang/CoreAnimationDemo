//
//  AnchorViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/11.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 旋转后要消除锯齿，可以设置
 [view].layer.shouldRasterize = true;
 [view].layer.rasterizationScale = UIScreen.main.scale
 */

class AnchorViewController: UIViewController {
    
    // 每一小时的弧度是: 每小时所占的份额(1 / 12) * 整圆的弧度(2π)
    static let everyHourAngle = (1.0 / 12.0) * 2.0 * CGFloat.pi
    
    weak var timer: Timer?

    @IBOutlet weak var view5_11: UIView! {
        didSet {
            let angle = AnchorViewController.everyHourAngle * 5
            view5_11.transform = CGAffineTransform(rotationAngle: angle)
            view5_11.layer.shouldRasterize = true
            view5_11.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    @IBOutlet weak var view4_10: UIView! {
        didSet {
            let angle = AnchorViewController.everyHourAngle * 4
            view4_10.transform = CGAffineTransform(rotationAngle: angle)
            view4_10.layer.shouldRasterize = true
            view4_10.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    @IBOutlet weak var view2_8: UIView! {
        didSet {
            let angle = AnchorViewController.everyHourAngle * 2
            view2_8.transform = CGAffineTransform(rotationAngle: angle)
            view2_8.layer.shouldRasterize = true
            view2_8.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    @IBOutlet weak var view1_7: UIView! {
        didSet {
            let angle = AnchorViewController.everyHourAngle
            view1_7.transform = CGAffineTransform(rotationAngle: angle)
            view1_7.layer.shouldRasterize = true
            view1_7.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    @IBOutlet weak var hourView: UIView! {
        didSet {
            hourView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
            hourView.layer.shouldRasterize = true
            hourView.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    @IBOutlet weak var minuteView: UIView! {
        didSet {
            minuteView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
            minuteView.layer.shouldRasterize = true
            minuteView.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    @IBOutlet weak var secondView: UIView! {
        didSet {
            secondView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
            secondView.layer.shouldRasterize = true
            secondView.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateTimeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeView), userInfo: nil, repeats: true)
        updateTimeView()
    }
    
    func updateTimeView() {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)

        let components = calendar?.components([.hour, .minute, .second], from: Date())
        
        if let hour = components?.hour, let minute = components?.minute, let second = components?.second
        {
            /*
             一圈的弧度为2π
             */
            
            /*
             小时分成12份, 当前小时的弧度是 hour / 12 + minute / 60.0 * 每小时所占的弧度
             */
            let hourAngle = 2.0 * CGFloat.pi * CGFloat(hour) / 12.0 + CGFloat(minute) / 60.0 * AnchorViewController.everyHourAngle
            hourView.transform = CGAffineTransform(rotationAngle: hourAngle)
            
            /*
             分钟分成60份, 当前分钟的弧度是 minute / 60
             */
            let minuteAngle = 2.0 * CGFloat.pi * CGFloat(minute) / 60.0
            minuteView.transform = CGAffineTransform(rotationAngle: minuteAngle)
            
            let secondAngle = 2.0 * CGFloat.pi * CGFloat(second) / 60.0
            secondView.transform = CGAffineTransform(rotationAngle: secondAngle)

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    deinit {
        print("deinit")
    }
}
