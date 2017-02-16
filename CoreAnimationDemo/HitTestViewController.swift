//
//  HitTestViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/14.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 hitTest :
 [layer].hitTest(CGPoint) -> CALayer? > 将会返回点击了的layer, 如果返回nil 代表没有点击到layer 及其子layer
 
 ----------------------------------------
 layer没有自动布局，可以设置layer的delegate ，在delegate的layoutSublayers 方法中重新设置sublayer的位置
 
 ----------------------------------------
 shadow:
 shadowOpacity: 默认是0，取值范围为[0, 1]， 阴影的透明度，0是完全透明，1是完全不透明
 shadowOffset : 默认是(0, -3), width 是横向偏移量，height 是纵向偏移量， height < 0 阴影向上，height > 0 阴影向下, width < 0 阴影向左， width > 0 阴影向右
 shadowRadius : 阴影的模糊度， 默认是3， 数字越大越模糊
 shadowPath : 阴影路径，可以通过设置这个值来指定图层的阴影路径
 
 ----------------------------------------
 
 */
class HitTestViewController: UIViewController {

    @IBOutlet weak var layerView: UIView!
    weak var blueLayer: CALayer!
    weak var grayLayer: CALayer!
    weak var layoutLayer: CALayer!
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            shadowView.layer.borderWidth = 1
            shadowView.layer.borderColor = UIColor.gray.cgColor
            
            // cornerRadius: 圆角半径， 默认是0 (即直角)
            shadowView.layer.cornerRadius = 5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let blueLayer = CALayer()
        blueLayer.backgroundColor = UIColor.blue.cgColor
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.zPosition = 1
        layerView.layer.addSublayer(blueLayer)
        self.blueLayer = blueLayer
        
        let grayLayer = CALayer()
        grayLayer.backgroundColor = UIColor.gray.cgColor
        grayLayer.frame = CGRect(x: 120, y: 60, width: 100, height: 100)
        layerView.layer.addSublayer(grayLayer)
        self.grayLayer = grayLayer
        
        let layoutLayer = CALayer()
        layoutLayer.backgroundColor = UIColor.black.cgColor
        layoutLayer.frame = CGRect(x: 0, y: layerView.bounds.height - 200, width: layerView.bounds.width, height: 200)
        layerView.layer.addSublayer(layoutLayer)
        layerView.layer.delegate = self
        self.layoutLayer = layoutLayer
    }
    
    deinit {
        layerView.layer.delegate = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
//        firstFunc(touch: touch)
        secondFunc(touch: touch)
    }
    
    // 逗比方法
    func firstFunc(touch: UITouch) {
        // 得到view.layer上的点
        var location = touch.location(in: view)
        // 从 view.layer上的point转换为layerView.layer上的点
        location = layerView.layer.convert(location, from: view.layer)
        if layerView.layer.contains(location) {
            location = blueLayer.convert(location, from: layerView.layer)
            if blueLayer.contains(location) {
                print("点击了蓝色layer")
            } else {
                print("点击了layerView")
            }
        }
    }
    
    // 正确方法
    func secondFunc(touch: UITouch) {
        let point = touch.location(in: view)
        if let layer = layerView.layer.hitTest(point) {
            if layer == grayLayer {
                print("点击了灰色layer")
            } else if layer == blueLayer {
                print("点击了蓝色layer")
            }else {
                print("点击了layerView")
            }
        } else {
            print("并没有点击到layerView")
        }
        
    }
    
    @IBAction func opacityDidChange(_ sender: UISlider) {
        shadowView.layer.shadowOpacity = sender.value
    }
    
    @IBAction func shadowOffsetDidChange(_ sender: UISlider) {
        shadowView.layer.shadowOffset = CGSize(width: CGFloat(sender.value), height: CGFloat(sender.value))
    }
    @IBAction func shadowRadiusDidChange(_ sender: UISlider) {
        shadowView.layer.shadowRadius = CGFloat(sender.value)
    }
}

extension HitTestViewController : CALayerDelegate {
    func layoutSublayers(of layer: CALayer) {
        layoutLayer.frame = CGRect(x: 0, y: layerView.bounds.height - 200, width: layerView.bounds.width, height: 200)

    }
}
