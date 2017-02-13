//
//  AnchorViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/11.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class AnchorViewController: UIViewController {
    
    // 每一小时的弧度是: 每小时所占的份额(1 / 12) * 整圆的弧度(2π)
    static let everyHourAngle = (1.0 / 12.0) * 2.0 * M_PI
    
    weak var timer: Timer?

    @IBOutlet weak var view5_11: UIView! {
        didSet {
            let angle = AnchorViewController.everyHourAngle * 5
            view5_11.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }
    }
    @IBOutlet weak var view4_10: UIView! {
        didSet {
            let angle = AnchorViewController.everyHourAngle * 4
            view4_10.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }
    }
    @IBOutlet weak var view2_8: UIView! {
        didSet {
            let angle = AnchorViewController.everyHourAngle * 2
            view2_8.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }
    }
    @IBOutlet weak var view1_7: UIView! {
        didSet {
            let angle = AnchorViewController.everyHourAngle
            view1_7.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
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
            let hourAngle = 2.0 * M_PI * Double(hour) / 12.0 + Double(minute) / 60.0 * AnchorViewController.everyHourAngle
            hourView.transform = CGAffineTransform(rotationAngle: CGFloat(hourAngle))
            
            /*
             分钟分成60份, 当前分钟的弧度是 minute / 60
             */
            let minuteAngle = 2.0 * M_PI * Double(minute) / 60.0
            minuteView.transform = CGAffineTransform(rotationAngle: CGFloat(minuteAngle))
            
            let secondAngle = 2.0 * M_PI * Double(second) / 60.0
            secondView.transform = CGAffineTransform(rotationAngle: CGFloat(secondAngle))

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
