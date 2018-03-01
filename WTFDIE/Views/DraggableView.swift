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
    var tabHeight: NSLayoutConstraint!
    var expandedHeight: CGFloat = 344
    var closedHeight: CGFloat = 60
    
    var maxHeight: CGFloat = 0
    var minHeight: CGFloat = 0
    
    var distanceMoved: CGFloat = 0
    
    var panGesture = UIPanGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        self.insertSubview(blurView, at: 0)
        
        /*
            NOTE Always make sure to activate constraints after adding the view to the parent otherwise it's illegal to activate constraints that do not have a common ancestor!
        */
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: self.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: self.widthAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        self.isUserInteractionEnabled = true
        panGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(panGesture)
        
        //+72 is the padding on the bottom
        maxHeight = UIScreen.main.bounds.height - self.frame.height/2 + 62
        // - 10 for some sort of error that occured lol
        print("centerRelative \(self.convert(self.center, to: self.superview))")
        //minHeight = self.center.y + self.frame.height - 72 - 48
        minHeight = UIScreen.main.bounds.height + self.frame.height/2 - 50
        print("MinHEIGHT \(minHeight)")
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.superview)
        
        let dragChange = self.center.y + translation.y
        
        /*
            checking if we are dragging past our allowable height, so can't drag off screen etc
            Remember that the coordinate system is (0,0) on the top left, which means moving down is an increase in height
        */
        if dragChange >= maxHeight {
            self.center = CGPoint(x: self.center.x, y: self.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.superview)
        }
        
        //can check velocity, negative means moving up, positive means moving down
        if sender.state == UIGestureRecognizerState.ended {
            self.superview?.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                if sender.velocity(in: self).y >= 0 {
                    self.center = CGPoint(x: self.center.x, y: self.minHeight)
                } else {
                    self.center = CGPoint(x: self.center.x, y: self.maxHeight)
                }
            }, completion: { (success) in
            })
        }
    }
    
    func collapseView() {
        self.superview?.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                self.center = CGPoint(x: self.center.x, y: self.minHeight)
        }, completion: { (success) in
        })
    }
}
