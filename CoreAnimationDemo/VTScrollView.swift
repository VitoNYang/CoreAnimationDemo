//
//  VTScrollView.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/19.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class VTScrollView: UIView {

    override class var layerClass: AnyClass {
        return CAScrollLayer.self
    }

    private var scrollViewLayer: CAScrollLayer {
        return self.layer as! CAScrollLayer
    }
    
    private func setup() {
        layer.masksToBounds = true
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(panGesture:)))
        addGestureRecognizer(recognizer)
    }
    
    func pan(panGesture: UIPanGestureRecognizer) {
        var offset = bounds.origin
        offset.x -= panGesture.translation(in: self).x
        offset.y -= panGesture.translation(in: self).y
        
        scrollViewLayer.scroll(to: offset)
        
        panGesture.setTranslation(.zero, in: self)
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
