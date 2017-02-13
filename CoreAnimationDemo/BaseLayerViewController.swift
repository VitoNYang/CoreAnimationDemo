//
//  BaseLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/11.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 CALayer的contents必须是CGImage
 UIView的 contentMode 等同于CALayer的contentsGravity
 UIView的 clipsToBounds 等同于CALayer的 masksToBounds
 
 contentsCenter: 只有在contentsCenter区域部分才会被拉伸压缩。区域外的会保持原大小
 */

class BaseLayerViewController: UIViewController {
    
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var contentsCenterView: UIView!
    
    @IBOutlet weak var layerDelegateView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addALayer()
        testContents()
        
    }
    
    func addALayer() {
        let blueLayer = CALayer()
        blueLayer.backgroundColor = UIColor.blue.cgColor
        blueLayer.frame = layerDelegateView.bounds - 10
        blueLayer.contentsScale = UIScreen.main.scale
        
        // set CALayer's delegate
        blueLayer.delegate = self
        layerDelegateView.layer.addSublayer(blueLayer)
        
        // redraw
        blueLayer.display()
    }
    
    func testContents() {
        if let image = UIImage(named: "01") {
            // contents
            layerView.layer.contents = image.cgImage
            // contentsGravity
            layerView.layer.contentsGravity = kCAGravityCenter
            // contentsScale
            layerView.layer.contentsScale = UIScreen.main.scale//image.scale
            // masksToBounds
            layerView.layer.masksToBounds = true
            
            
            contentsCenterView.layer.contents = image.cgImage
        }
    }
}

extension BaseLayerViewController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.setLineWidth(5)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.strokeEllipse(in: layer.bounds)
//        ctx.setFillColor(UIColor.black.cgColor)
//        ctx.fillEllipse(in: layer.bounds)
    }
}

