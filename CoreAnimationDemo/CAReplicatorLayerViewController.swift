//
//  CAReplicatorLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/19.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CAReplicatorLayerViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 创建CAReplicatorLayer
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = containerView.bounds
        containerView.layer.addSublayer(replicatorLayer)
        // 设置复制个数
        replicatorLayer.instanceCount = 10
        
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 200, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi / 5.0, 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -200, 0)
        replicatorLayer.instanceTransform = transform
        
        replicatorLayer.instanceBlueOffset = -0.1
        replicatorLayer.instanceGreenOffset = -0.1
        
        // 创建一个子layer 并添加到replicator layer中
        let layer = CALayer()
        layer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        layer.backgroundColor = UIColor.white.cgColor
        replicatorLayer.addSublayer(layer)
    }

}
