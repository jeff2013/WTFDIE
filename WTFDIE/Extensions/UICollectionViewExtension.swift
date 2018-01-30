//
//  UICollectionViewExtension.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-26.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    func registerCellTypes(types: [UICollectionViewCell.Type]) {
        for type in types {
            self.register(UINib(nibName: type.defaultReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: type.defaultReuseIdentifier)
        }
    }
}
