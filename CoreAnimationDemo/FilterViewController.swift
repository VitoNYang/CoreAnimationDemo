//
//  FilterViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/15.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    weak var timer: Timer?
    @IBOutlet var digitViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let image = #imageLiteral(resourceName: "numbers").cgImage
        for digitView in digitViews {
            digitView.layer.contents = image
            digitView.layer.contentsGravity = kCAGravityResizeAspect
            digitView.layer.contentsRect = CGRect(x: 0, y: 0, width: 0.1, height: 1.0)
            
            digitView.layer.magnificationFilter = kCAFilterNearest
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    func updateTime() {
        let calendar = NSCalendar(calendarIdentifier: .gregorian)
        let components = calendar?.components([.hour,.minute,.second], from: Date())
        guard let hour = components?.hour, let minute = components?.minute, let second = components?.second else {
            return
        }
        
        set(digit: hour / 10, for: digitViews[0])
        set(digit: hour % 10, for: digitViews[1])
        
        set(digit: minute / 10, for: digitViews[2])
        set(digit: minute % 10, for: digitViews[3])
        
        set(digit: second / 10, for: digitViews[4])
        set(digit: second % 10, for: digitViews[5])
        
    }
    
    func set(digit: Int, for view: UIView) {
        view.layer.contentsRect = CGRect(x: CGFloat(digit) * 0.1, y: 0, width: 0.1, height: 1.0)
    }

}
