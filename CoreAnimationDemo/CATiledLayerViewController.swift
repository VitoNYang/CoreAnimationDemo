//
//  CATiledLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/2/20.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class CATiledLayerViewController: UIViewController {

    weak var tileLayer: VTTiledLayer?
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tileLayer = VTTiledLayer()
        tileLayer.frame = CGRect(x: 0, y: 0, width: 1440 / UIScreen.main.scale, height: 900 / UIScreen.main.scale)
        tileLayer.contentsScale = UIScreen.main.scale
        tileLayer.delegate = self
        
        scrollView.layer.addSublayer(tileLayer)
        scrollView.contentSize = tileLayer.frame.size
        
        tileLayer.setNeedsDisplay()
        self.tileLayer = tileLayer
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tileLayer?.delegate = nil
    }
}

extension CATiledLayerViewController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        guard let tiledLayer = layer as? CATiledLayer else {
            return
        }
        let bounds = ctx.boundingBoxOfClipPath

        let scale = UIScreen.main.scale
        let x = Int(floor(bounds.origin.x / tiledLayer.tileSize.width * scale))
        let y = Int(floor(bounds.origin.y / tiledLayer.tileSize.height * scale))
        
        let imageName = String(format: "04_%02i_%02i", x, y)
        
        guard let imagePath = Bundle.main.path(forResource: imageName, ofType: "jpg"), let tileImage = UIImage(contentsOfFile: imagePath)  else {
            return
        }
        UIGraphicsPushContext(ctx)
        tileImage.draw(in: bounds)
        UIGraphicsPopContext()
    }
}

class VTTiledLayer: CATiledLayer {
    override class func fadeDuration() -> CFTimeInterval {
        return 0
    }
}
