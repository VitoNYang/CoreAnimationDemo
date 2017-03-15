//
//  KeyframeAnimationWithTimingFunctionViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/3/13.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class KeyframeAnimationWithTimingFunctionViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    lazy var ballView: UIView = {
        $0.backgroundColor = UIColor.red
        return $0
    }(UIView())

    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.addSubview(ballView)
        ballView.translatesAutoresizingMaskIntoConstraints = false
        ballView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        ballView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        ballView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        ballView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        animate()
    }

    private func animate() {
        let centerX = containerView.center.x - 15
        let positionY = containerView.bounds.height - 15
        // reset ball to top
        ballView.center = CGPoint(x: centerX, y: 10 + 15)
        
        // set up animation parameters
        let fromValue = CGPoint(x: centerX, y: ballView.center.y)
        let toValue = CGPoint(x: centerX, y: positionY)
        let duration: CGFloat = 1.0
        
        // generate keyframes
        let numFrames = Int(duration * 60)
        var frames = [Any]()
        
        for i in 0 ..< numFrames {
            var time = 1 / CGFloat(numFrames) * CGFloat(i)
            time = bounceEaseOut(t: time)
            frames.append(interpolateFromValue(fromValue: fromValue, toValue: toValue, time: time))
        }
        
        // create keyframe animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 1.0
        animation.values = frames
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        ballView.layer.add(animation, forKey: nil)
        
        /*let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 1
        animation.delegate = self
        animation.values = [CGPoint(x: centerX, y: 10),
                            CGPoint(x: centerX, y: positionY),
                            CGPoint(x: centerX, y: positionY - 60),
                            CGPoint(x: centerX, y: positionY),
                            CGPoint(x: centerX, y: positionY - 30),
                            CGPoint(x: centerX, y: positionY),
                            CGPoint(x: centerX, y: positionY - 15),
                            CGPoint(x: centerX, y: positionY)
                           ]
        animation.timingFunctions =
            [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
             CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
             CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
             CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
             CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
             CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
             CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            ]
        animation.keyTimes =
            [0.3,
             0.5,
             0.7,
             0.8,
             0.9,
             0.95,
             1.0
            ]
        ballView.layer.position = CGPoint(x: centerX, y: positionY)
        ballView.layer.add(animation, forKey: nil)
        */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate()
    }

}

extension KeyframeAnimationWithTimingFunctionViewController: CAAnimationDelegate {
    
}

func interpolate(from: CGFloat, to: CGFloat, time: CGFloat) -> CGFloat{
    return (to - from) * time + from
}

func interpolateFromValue(fromValue: Any, toValue: Any, time: CGFloat) -> Any{
    if let fromValuePoint = fromValue as? CGPoint, let toValuePoint = toValue as? CGPoint {
        let result =
            CGPoint(x: interpolate(from: fromValuePoint.x, to: toValuePoint.x, time: time),
                    y: interpolate(from: fromValuePoint.y, to: toValuePoint.y, time: time))
        return result
    }
    return (time < 0.5) ? fromValue : toValue
}

func bounceEaseOut(t: CGFloat) -> CGFloat{
    if t < 4 / 11.0 {
        return (121 * t * t) / 16.0
    } else if t < 8 / 11.0 {
        return (363 / 40.0 * t * t) - (99 / 10.0 * t) + 17 / 5.0
    } else if t < 9 / 10.0 {
        return (4356 / 361.0 * t * t) - (35442 / 1805.0 * t) + 16061 / 1805.0
    }
    return (54 / 5.0 * t * t) - (513 / 25.0 * t) + 268 / 25.0
}
