//
//  Util.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/6.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

// view snapshot

extension UIView {
    // render(in:) 方法不能对子图层正确地处理编号效果, 并且对视频和OpenGL内容也不起作用
    var snapshot: UIImage? {
        
        // 设置上下文信息
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0)
        
        // 获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        // 把layer 绘制到上下文中
        layer.render(in: context)
        
        // 从当前上下文中获取image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
    }
}
