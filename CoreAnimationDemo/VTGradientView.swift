//
//  VTGradientView.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/19.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 一个实现了渐变的View
 */
open class VTGradientView: UIView {
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    private var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    open var colors: [Any]? {
        didSet {
            gradientLayer.colors = colors
        }
    }
    
    /// 可选, 如果有设置的话, 将会均匀的渲染colors, 如果设置的话则要和colors的长度一样, 否则将会得到空白的渐变, 0.0代表开始, 1.0代表结束
    open var locations: [NSNumber]? {
        didSet {
            gradientLayer.locations = locations
        }
    }
    
    open var startPoint: CGPoint {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }
    
    open var endPoint: CGPoint {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }
    
    private static let defaultStartPoint = CGPoint(x: 0.5, y: 0)
    private static let defaultEndPoint = CGPoint(x: 0.5, y: 1)

    init(startPoint: CGPoint = defaultStartPoint, endPoint: CGPoint = defaultEndPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.startPoint = VTGradientView.defaultStartPoint
        self.endPoint = VTGradientView.defaultEndPoint
        super.init(coder: aDecoder)
    }
    
}
