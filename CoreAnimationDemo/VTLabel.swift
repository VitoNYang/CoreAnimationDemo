//
//  VTLabel.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/17.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class VTLabel: UILabel {
    override class var layerClass: Swift.AnyClass {
        return CATextLayer.self
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
    
    var textLayer: CATextLayer {
        return self.layer as! CATextLayer
    }
    
    func setup() {
        font = super.font
        text = super.text
        textColor = super.textColor
        layer.display()
    }
    
    override var text: String? {
        didSet {
            textLayer.string = text
        }
    }
    
    override var textColor: UIColor! {
        didSet {
            textLayer.foregroundColor = textColor.cgColor
        }
    }
    
    override var font: UIFont! {
        didSet {
            let fontName = font.fontName
            textLayer.font = fontName as CFTypeRef?
            textLayer.fontSize = font.pointSize
        }
    }
}
