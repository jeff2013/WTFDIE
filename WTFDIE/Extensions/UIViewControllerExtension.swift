//
//  UIViewControllerExtension.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-09-28.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public class func instanceFromStoryboard<T>(storyboard: Storyboard) -> T {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    public class func initialViewControllerFromStoryboard<T>(storyboard: Storyboard) -> T {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateInitialViewController() as! T
    }
    
    func preloadView() {
        _ = view
    }
    
    func setTitle(title: String) {
        navigationItem.title = title
        setBackButton()
    }
    
    func setTitleView(view: UIView) {
        navigationItem.titleView = view
        setBackButton()
    }
    
    private func setBackButton() {
        let backButton = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
}
