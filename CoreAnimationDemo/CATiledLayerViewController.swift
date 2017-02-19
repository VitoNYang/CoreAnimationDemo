//
//  CATiledLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/20.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CATiledLayerViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tileLayer = CATiledLayer()
        tileLayer.frame = CGRect(x: 0, y: 0, width: 3120, height: 4208)
        tileLayer.delegate = self
        
        scrollView.layer.addSublayer(tileLayer)
        scrollView.contentSize = tileLayer.frame.size
        
        tileLayer.setNeedsDisplay()
    }
}

extension CATiledLayerViewController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        guard let tiledLayer = layer as? CATiledLayer else {
            return
        }
        let bounds = ctx.boundingBoxOfClipPath
        let x = Int(floor(bounds.origin.x / tiledLayer.tileSize.width))
        let y = Int(floor(bounds.origin.y / tiledLayer.tileSize.height))
        
        let imageName = String(format: "IMG_20161226_221947._%02i_%02i", x, y)
        
        guard let imagePath = Bundle.main.path(forResource: imageName, ofType: "jpg"), let tileImage = UIImage(contentsOfFile: imagePath)  else {
            return
        }
        UIGraphicsPushContext(ctx)
        tileImage.draw(in: bounds)
        UIGraphicsPopContext()
    }
}
