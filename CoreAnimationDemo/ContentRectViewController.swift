//
//  ContentRectViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/11.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

/*
 
 CALayer的contentRect是设置contents的显示区域范围是[0 0 1 1]
 
 */

class ContentRectViewController: UIViewController {

    @IBOutlet weak var bottomRightView: UIView!{
        didSet {
            bottomRightView.layer.borderColor = UIColor.white.cgColor
            bottomRightView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var bottomLeftView: UIView!{
        didSet {
            bottomLeftView.layer.borderColor = UIColor.white.cgColor
            bottomLeftView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var topRightView: UIView!{
        didSet {
            topRightView.layer.borderColor = UIColor.white.cgColor
            topRightView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var topLeftView: UIView!{
        didSet {
            topLeftView.layer.borderColor = UIColor.white.cgColor
            topLeftView.layer.borderWidth = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let cgImage = UIImage(named: "02")?.cgImage {

            topLeftView.layer.contents = cgImage
            topRightView.layer.contents = cgImage
            bottomLeftView.layer.contents = cgImage
            bottomRightView.layer.contents = cgImage
            topLeftView.layer.contentsRect = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
            
            topRightView.layer.contentsRect = CGRect(x: 0.5, y: 0, width: 0.5, height: 0.5)
            bottomLeftView.layer.contentsRect = CGRect(x: 0, y: 0.5, width: 0.5, height: 0.5)
            bottomRightView.layer.contentsRect = CGRect(x: 0.5, y: 0.5, width: 0.5, height: 0.5)
        }
    }
}
