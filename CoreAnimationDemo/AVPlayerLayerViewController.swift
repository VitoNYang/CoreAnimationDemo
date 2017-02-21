//
//  AVPlayerLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/21.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit
import AVFoundation

class AVPlayerLayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    lazy var player: AVPlayer? = {
        // video url
        guard let url = Bundle.main.url(forResource: "Missile", withExtension: "mov") else {
            return nil
        }
        
        // create player and player layer
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        self.view.layer.addSublayer(playerLayer)
        self.playerLayer = playerLayer
        return player
    }()
    
    var playerLayer: AVPlayerLayer?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        playerLayer?.frame = view.bounds
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }

}
