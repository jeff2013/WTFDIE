//
//  UITableviewExtension.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-08.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func registerCellTypes(types: [UITableViewCell.Type]) {
        for type in types {
            self.register(UINib(nibName: type.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: type.defaultReuseIdentifier)
        }
    }
    
    //make sure reuse identifier and class names are identical
    func dequeueReusableCell<T>(type: T.Type) -> T where T: ReusableView {
        return self.dequeueReusableCell(withIdentifier: type.defaultReuseIdentifier) as! T
    }
}
