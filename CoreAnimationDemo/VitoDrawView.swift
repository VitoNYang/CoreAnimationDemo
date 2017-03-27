//
//  VitoDrawView.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/27.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class VitoDrawView : UIView {
    var path = UIBezierPath()
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    var shapeLayer: CAShapeLayer {
        assert(layer is CAShapeLayer, "Layer Must be CAShapeLayer")
        
        return layer as! CAShapeLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        let shapeLayer = self.shapeLayer
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.drawsAsynchronously = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        path.move(to: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        path.addLine(to: location)
        
        self.shapeLayer.path = path.cgPath
    }
}
