//
//  CATextLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/17.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CATextLayerViewController: UIViewController {
    
    @IBOutlet weak var layerView: UIView!
    
    lazy var textLayer: CATextLayer = {
        // 创建CATextLayer
        let layer = CATextLayer()
        
        // 设置字体
        let fontName: CFString = "Noteworthy-Light" as CFString
        layer.font = fontName//CTFontCreateWithName(fontName, 10, nil)
        
        // 设置字体大小
        layer.fontSize = 27
        
        // 设置文字对齐方式
        layer.alignmentMode = kCAAlignmentCenter
        
        // 设置是否换行，默认是不换行的
        layer.isWrapped = true
        
        // 设置字体颜色
        layer.foregroundColor = UIColor.red.cgColor
        
        layer.truncationMode = kCATruncationMiddle
        
        // 设置文字
        let text = "override func viewWillAppear(_ animated: Bool) \n"
                 + "{ \n"
                 + "     super.viewWillAppear(animated)\n"
                 + "     layerView.layer.addSublayer(textLayer)\n"
                 + "}"
        layer.string = text
        
        // 防止文字模糊，需要设置contentsScale
        layer.contentsScale = UIScreen.main.scale
        
        
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layerView.layer.addSublayer(textLayer)
        textLayer.frame = layerView.layer.bounds
    }

}
