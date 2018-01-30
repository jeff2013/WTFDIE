//
//  DraggableView.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-12-16.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

class DraggableView: UIView {

    var startPosition: CGPoint?
    var originalHeight: CGFloat = 0
    var customViewHeight: NSLayoutConstraint!
    var expandedHeight: CGFloat = 344
    var closedHeight: CGFloat = 60
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startPosition = touch?.location(in: self)
        originalHeight = customViewHeight.constant
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let endPosition = touch?.location(in: self)
        if let endPosition = endPosition, let startPosition = startPosition {
            let difference = endPosition.y - startPosition.y
            
            /*
             NOTE: always make sure to "sync" animations otherwise it causes jittery animations since there could be > 1 animations trying to complete at one time. Also make sure that the animations are synced are the superview not just the singular views.
             */
            self.superview?.layoutIfNeeded()
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.customViewHeight.constant = difference > 0 ? self.closedHeight : self.expandedHeight
                self.superview?.layoutIfNeeded()
            })
        }
    }
}
