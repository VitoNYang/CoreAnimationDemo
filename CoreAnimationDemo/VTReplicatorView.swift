//
//  VTReplicatorView.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/19.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 一个实现了倒影效果的View
 */
class VTReplicatorView: UIView {
    override class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }
    
    private var replicatorLayer: CAReplicatorLayer {
        return self.layer as! CAReplicatorLayer
    }
    
    override var bounds: CGRect {
        didSet {
            setupLayerTransform()
        }
    }
    
    var reflectionAlpha: Float = -0.7 {
        didSet {
            replicatorLayer.instanceAlphaOffset = reflectionAlpha
        }
    }
    
    private func setupLayerTransform() {
        // 设置形变
        var transform = CATransform3DIdentity
        let verticalOffset = bounds.size.height + 2
        transform = CATransform3DTranslate(transform, 0, verticalOffset, 0)
        transform = CATransform3DScale(transform, 1, -1, 0)
        replicatorLayer.instanceTransform = transform
    }
    
    private func setup() {
        // configure replicator
        let layer = replicatorLayer
        layer.instanceCount = 2
        
        setupLayerTransform()
        
        layer.instanceAlphaOffset = reflectionAlpha
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

}
