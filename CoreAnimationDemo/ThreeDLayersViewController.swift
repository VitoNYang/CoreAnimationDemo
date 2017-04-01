//
//  ThreeDLayersViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/28.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class ThreeDLayersViewController: UIViewController {
    
    let WIDTH: CGFloat = 100
    let HEIGHT: CGFloat = 100
    let DEPTH = 10
    let SIZE = 100
    let SPACING: CGFloat = 150
    let CAMERA_DISTANCE: CGFloat = 500
    // 缓存池
    var recyclePool = NSMutableSet()

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = CGSize(width: (WIDTH - 1) * SPACING, height: (HEIGHT - 1) * SPACING)
            
            var transform = CATransform3DIdentity
            transform.m34 = -1 / CAMERA_DISTANCE
            scrollView.layer.sublayerTransform = transform
            scrollView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .gray
//        setupScrollView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLayers()
    }
    
    private func setupScrollView() {
        // create layers
        for z in (0 ... DEPTH - 1).reversed() {
            for y in 0 ..< Int(HEIGHT) {
                for x in 0 ..< Int(WIDTH) {
                    let layer = CALayer()
                    layer.frame = CGRect(x: 0, y: 0, width: SIZE, height: SIZE)
                    layer.position = CGPoint(x: x.cgFloat * SPACING, y: y.cgFloat * SPACING)
                    layer.zPosition = -z.cgFloat * SPACING
                    layer.backgroundColor = UIColor(white: 1 - z.cgFloat * (1 / DEPTH.cgFloat), alpha: 1).cgColor
                    
                    scrollView.layer.addSublayer(layer)
                }
            }
        }
    }
    
    func updateLayers() {
        var bounds = scrollView.bounds
        bounds.origin = scrollView.contentOffset
        bounds = bounds.insetBy(dx: -SIZE.cgFloat / 2, dy: -SIZE.cgFloat / 2)
        if let sublayers = scrollView.layer.sublayers {
            recyclePool.addObjects(from: sublayers)
        }
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        var visibleLayers = [CALayer]()
        for z in (0 ... DEPTH - 1).reversed() {
            var adjusted = bounds
            adjusted.size.width /= perspective(z: z.cgFloat * SPACING)
            adjusted.size.height /= perspective(z: z.cgFloat * SPACING)
            adjusted.origin.x -= (adjusted.width - bounds.width) / 2
            adjusted.origin.y -= (adjusted.height - bounds.height) / 2
            for y in 0 ..< Int(HEIGHT) {
                if y.cgFloat * SPACING < adjusted.origin.y || y.cgFloat * SPACING >= adjusted.origin.y + adjusted.height {
                    continue
                }
                for x in 0 ..< Int(WIDTH) {
                    if x.cgFloat * SPACING < adjusted.origin.x || x.cgFloat * SPACING >= adjusted.origin.x + adjusted.width {
                        continue
                    }
                    var layer = recyclePool.anyObject() as? CALayer
                    if layer != nil {
                        recyclePool.remove(layer!)
                    } else {
                        layer = CALayer()
                        layer?.frame = CGRect(x: 0, y: 0, width: SIZE, height: SIZE)
                    }
                    layer?.position = CGPoint(x: x.cgFloat * SPACING, y: y.cgFloat * SPACING)
                    layer?.zPosition = -z.cgFloat * SPACING
                    
                    layer?.backgroundColor = UIColor(white: 1 - z.cgFloat * (1 / DEPTH.cgFloat), alpha: 1).cgColor
                    visibleLayers.append(layer!)
                }
            }
        }
        CATransaction.commit()
        scrollView.layer.sublayers = visibleLayers
    }

    func perspective(z: CGFloat) -> CGFloat{
        return CAMERA_DISTANCE / (z + CAMERA_DISTANCE)
    }
}

extension ThreeDLayersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateLayers()
    }
}

class VitoLayer: CALayer {
    deinit {
        print("VitoLayer deinit")
    }
}

