//
//  UIViewExtension.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-11-07.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func resetAnimation(){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.beginFromCurrentState],
                       animations: {
                        self.alpha = 1.0
                        self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func animateCircle(with duration: Double, shouldRepeat: Bool) {
        let options: UIViewKeyframeAnimationOptions = shouldRepeat ? [.repeat] : []
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: options, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(90.0 * Double.pi)/180.0).concatenating(CGAffineTransform(scaleX: 1.05, y: 1.05))
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(180.0 * Double.pi)/180.0).concatenating(CGAffineTransform(scaleX: 1.1, y: 1.1))
            })
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(270.0 * Double.pi)/180.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(360.0 * Double.pi)/180.0)
            })
        })
    }
}
