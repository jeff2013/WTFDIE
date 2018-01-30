//
//  ReusableView.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-08.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

public protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UICollectionViewCell: ReusableView {}
