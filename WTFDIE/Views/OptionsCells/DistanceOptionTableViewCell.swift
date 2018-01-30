//
//  DistanceOptionTableViewCell.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-09.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

class DistanceOptionTableViewCell: ExpandableUITableViewCell {

    @IBOutlet weak var rangeSelector: UISlider?
    
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet weak var rangeLabel: UILabel?
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override var isExpanded:Bool {
        didSet {
            if !isExpanded {
                self.heightConstraint.constant = 0
            } else {
                self.heightConstraint.constant = 68
            }
        }
    }
    
    typealias configurableObject = Int
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    @IBAction func rangeChanged(_ sender: UISlider) {
        rangeLabel?.attributedText = "\(String(format: "%.2f", sender.value)) km".styled(.cellTitle)
        delegate.updateParameters(with: "radius", value: String(format: "%.2f", sender.value * 1000))
    }
    
    private func setupView() {
        titleLabel?.attributedText = "Radius (km)".styled(.cellTitle)
        rangeLabel?.attributedText = "5 km".styled(.cellTitle)
    }
}

extension DistanceOptionTableViewCell: ConfigurableTableViewCellProtocol {
    func configureCell(object: configurableObject) {
    }
}
