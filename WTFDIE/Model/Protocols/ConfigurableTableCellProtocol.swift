//
//  ConfigurableTableCellProtocol.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-08.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import Foundation

protocol ConfigurableTableViewCellProtocol {
    associatedtype configurableObject
    
    func configureCell(object: configurableObject)
}

protocol ConfigurableCollectionViewCellProtocol {
    associatedtype configurableObject
    
    func configureCell(object: configurableObject)
}
