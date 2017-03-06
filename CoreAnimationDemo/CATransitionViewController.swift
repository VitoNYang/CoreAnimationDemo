//
//  CATransitionViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/6.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

enum VTAnimationType {
    case fade, moveIn, push, reveal
    
    var caanimationType : String {
        switch self {
        case .fade:
            return kCATransitionFade
        case .moveIn:
            return kCATransitionMoveIn
        case .push:
            return kCATransitionPush
        case .reveal:
            return kCATransitionReveal
        }
    }
    
    static func randomType() -> VTAnimationType {
        return [fade, moveIn, push, reveal].sorted { _ in arc4random() < arc4random() }.first!
    }
}

enum VTAnimationSubtype {
    case left, right, top, bottom
    
    var caanimationSubtype: String {
        switch self {
        case .left:
            return kCATransitionFromLeft
        case .right:
            return kCATransitionFromRight
        case .top:
            return kCATransitionFromTop
        case .bottom:
            return kCATransitionFromBottom
        }
    }
    
    static func randomType() -> VTAnimationSubtype {
        return [left, right, top, bottom].sorted { _ in arc4random() < arc4random() }.first!
    }
}

/*
 CATransition
 */
class CATransitionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
//            imageView.clipsToBounds = true
            imageView.layer.masksToBounds = true
        }
    }
    
    lazy var images: [UIImage] = {
        return (1...4).map{ String(format: "%02i", $0) }.map { UIImage(named: $0)! }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = images.first
    }
    
    @IBAction func switchImage(_ sender: UIButton) {
        /*
        let transition = CATransition()
        transition.type = VTAnimationType.randomType().caanimationType
        transition.subtype = VTAnimationSubtype.randomType().caanimationSubtype
        transition.duration = 2
        imageView.layer.add(transition, forKey: nil)
         if let currentImage = imageView.image {
         if let index = images.index(of: currentImage) {
         imageView.image = images[(index + 1) % images.count]
         return
         }
         }
         imageView.image = images.first
        */

        UIView.transition(with: imageView, duration: 3, options: .transitionCrossDissolve, animations: {
            if let currentImage = self.imageView.image {
                if let index = self.images.index(of: currentImage) {
                    self.imageView.image = self.images[(index + 1) % self.images.count]
                    return
                }
            }
            self.imageView.image = self.images.first
        }, completion: nil)

    }
    
    @IBAction func changeBackgroundColor(_ sender: UIButton) {
        let covertImage = view.snapshot
        let covertView = UIImageView(image: covertImage)
        covertView.frame = view.frame
        view.addSubview(covertView)
        view.backgroundColor = UIColor.randomColor
        
        UIView.animate(withDuration: 1, animations: {
            var transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            transform = transform.rotated(by: CGFloat.pi / 2)
            covertView.transform = transform
            covertView.alpha = 0
        }) { _ in
            covertView.removeFromSuperview()
        }
    }
}
