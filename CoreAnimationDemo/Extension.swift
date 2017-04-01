//
//  Extension.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/11.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

func -(lhs: CGRect, rhs: CGFloat) -> CGRect{
    let newWidth = lhs.width - rhs
    let newHeight = lhs.height - rhs
    let newX = (lhs.width - newWidth) / 2
    let newY = (lhs.height - newHeight) / 2
    return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
}

extension UIColor {
    class var randomColor: UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension Int {
    var float: Float {
        return Float(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}
