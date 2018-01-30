//
//  ExpandableUITableViewCell.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-09.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import Foundation
import UIKit

class ExpandableUITableViewCell: UITableViewCell {
    open var isExpanded: Bool = false
    open var delegate: DataChangedDelegate!
}
