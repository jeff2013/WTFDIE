//
//  SearchTypeTableViewCell.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-08.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

//Available types here
//https://developers.google.com/places/web-service/supported_types
enum SearchType: Int {
    case restaurant
    case cafe
    case Count
    
    var description: String {
        switch self {
        case .restaurant:
            return "Restaurant"
        case .cafe:
            return "Cafe"
        default:
            return ""
        }
    }
}

class SearchTypeTableViewCell: ExpandableUITableViewCell {
    
    typealias configurableObject = String

    @IBOutlet weak var tableView: UITableView?
    
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet weak var selectedGenre: UILabel?
    
    @IBOutlet weak var expandedIcon: UIImageView?
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var selectedType: SearchType = SearchType.restaurant
    
    override var isExpanded:Bool {
        didSet {
            if !isExpanded {
                self.heightConstraint.constant = 0.0
            } else {
                self.heightConstraint.constant = 150.0
            }
            expandedIcon?.image = isExpanded ? UIImage(named: "ExpandedIcon") : UIImage(named: "UnExpandedIcon")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.registerCellTypes(types: [SearchTypeOptionTableViewCell.self])
        tableView?.estimatedRowHeight = 50
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.tableFooterView = UIView()
    }
    
    func changeSelectedType(with selectedIndex: IndexPath) {
        selectedType = SearchType(rawValue: selectedIndex.row)!
        selectedGenre?.attributedText = selectedType.description.styled(.titleHeader)
        delegate.updateParameters(with: "type", value: selectedType.description.lowercased())
        tableView?.reloadData()
    }

}

extension SearchTypeTableViewCell: ConfigurableTableViewCellProtocol {
    func configureCell(object: configurableObject) {
        titleLabel?.attributedText = object.styled(.titleHeader)
        selectedGenre?.attributedText = selectedType.description.styled(.titleHeader)
        expandedIcon?.image = isExpanded ? UIImage(named: "ExpandedIcon") : UIImage(named: "UnExpandedIcon")
    }
}

extension SearchTypeTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchType.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchOptionCell: SearchTypeOptionTableViewCell =  tableView.dequeueReusableCell(type: SearchTypeOptionTableViewCell.self)
        searchOptionCell.configureCell(object: (SearchType(rawValue: indexPath.row)!.description, selectedType.description))
        return searchOptionCell
    }
}

extension SearchTypeTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        changeSelectedType(with: indexPath)
    }
}
