//
//  PriceSelectionTableViewCell.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-09.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

class PriceSelectionTableViewCell: ExpandableUITableViewCell {

    typealias configurableObject = PriceRange
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override var isExpanded:Bool {
        didSet {
            if !isExpanded {
                self.heightConstraint.constant = 0
            } else {
                self.heightConstraint.constant = 59
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.attributedText = "Price Range".styled(.cellTitle)
    }

    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        if let priceRange = PriceRange(rawValue: sender.selectedSegmentIndex) {
            selectedLabel.attributedText = priceRange.dollarValue.styled(.cellTitle)
            
            delegate.updateParameters(with: "minprice", value: priceRange.minMaxPrice.0)
            delegate.updateParameters(with: "maxPrice", value: priceRange.minMaxPrice.1)
        }
        
    }
}

extension PriceSelectionTableViewCell: ConfigurableTableViewCellProtocol {
    func configureCell(object: configurableObject) {
        selectedLabel.attributedText = object.dollarValue.localized.styled(.cellTitle)
        segmentControl.selectedSegmentIndex = object.rawValue
    }
}
