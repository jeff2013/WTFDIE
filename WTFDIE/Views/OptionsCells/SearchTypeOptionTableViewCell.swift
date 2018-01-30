//
//  SearchTypeOptionTableViewCell.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-08.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

class SearchTypeOptionTableViewCell: UITableViewCell {
    
    typealias configurableObject = (String, String)
    
    var searchTypeTitleLabel: UILabel!
    
    var checkedImageView: UIImageView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        
        searchTypeTitleLabel = UILabel(frame: CGRect(x: 15, y: (self.frame.height - 30)/2, width: 100, height: 30))
        self.addSubview(searchTypeTitleLabel)
        
        checkedImageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 60, y: (self.frame.height - 30)/2, width: 30, height: 30))
        self.addSubview(checkedImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

extension SearchTypeOptionTableViewCell: ConfigurableTableViewCellProtocol {
    func configureCell(object: configurableObject) {
        searchTypeTitleLabel.attributedText = object.0.description.localized.styled(.cellTitle)
        if object.0 == object.1 {
            checkedImageView.image = UIImage(named: "selectedItemIcon")
        } else {
            checkedImageView.image = UIImage(named: "notSelectedIcon")
        }
    }
}
