//
//  CATransitionTabBarController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/6.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CATransitionTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
    }

}

extension CATransitionTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        let transition = CATransition()
        transition.type = VTAnimationType.randomType().caanimationType
        transition.subtype = VTAnimationSubtype.randomType().caanimationSubtype
        transition.duration = 5
        self.view.layer.add(transition, forKey: nil)
    }
}
