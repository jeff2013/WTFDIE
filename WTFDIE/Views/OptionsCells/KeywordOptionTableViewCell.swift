//
//  KeywordOptionTableViewCell.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-09.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

enum Keyword: Int {
    case breakfast
    case lunch
    case dinner
    case seafood
    case steak
    case brunch
    case chinese
    case japanese
    case sushi
    case dessert
    case vietnamese
    case ramen
    case dimSum
    case korean
    case italian
    case greek
    case casual
    case formal
    case dateNight
    case romantic
    case fastFood
    case takeOut
    case count
    
    var description: String {
        switch self {
        case .breakfast:
            return "Breakfast"
        case .lunch:
            return "Lunch"
        case .dinner:
            return "Dinner"
        case .seafood:
            return "Seafood"
        case .steak:
            return "Steak"
        case .brunch:
            return "Brunch"
        case .chinese:
            return "Chinese"
        case .japanese:
            return "Japanese"
        case .sushi:
            return "Sushi"
        case .dessert:
            return "Dessert"
        case .vietnamese:
            return "Vietnamese"
        case .ramen:
            return "Ramen"
        case .dimSum:
            return "Dim Sum"
        case .korean:
            return "Korean"
        case .italian:
            return "Italian"
        case .greek:
            return "Greek"
        case .casual:
            return "Casual"
        case .formal:
            return "Formal"
        case .dateNight:
            return "Date Night"
        case .romantic:
            return "Romantic"
        case .fastFood:
            return "Fast Food"
        case .takeOut:
            return "Take out"
        default:
            return ""
        }
    }
}

class KeywordOptionTableViewCell: ExpandableUITableViewCell {
    
    typealias configurableObject = String
    
    @IBOutlet weak var tableView: UITableView?
    
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet weak var selectedGenre: UILabel?
    
    @IBOutlet weak var expandedIcon: UIImageView?
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override var isExpanded:Bool {
        didSet {
            if !isExpanded {
                self.heightConstraint.constant = 0.0
            } else {
                self.heightConstraint.constant = 250.0
            }
            expandedIcon?.image = isExpanded ? UIImage(named: "ExpandedIcon") : UIImage(named: "UnExpandedIcon")
        }
    }
    
    var selectedKeywords = Set<Int>()

    var keywordParameters: String {
        get {
            return selectedKeywords.reduce("") { (acc, value) -> String in
                "\(acc), \(Keyword(rawValue: value)?.description ?? "")"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
        setupCell()
    }
    
    private func setupCell(){
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.registerCellTypes(types: [KeywordTableViewCell.self])
        tableView?.estimatedRowHeight = 50
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.tableFooterView = UIView()
        
        selectedGenre?.attributedText = "None".styled(.titleHeader)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func changeSelectedType(with selectedIndex: IndexPath) {
       
        
        if selectedKeywords.contains(selectedIndex.row) {
            selectedKeywords.remove(selectedIndex.row)
        } else {
            selectedKeywords.insert(selectedIndex.row)
        }
        
        if selectedKeywords.count == 0 {
            selectedGenre?.attributedText = "None".styled(.titleHeader)
        } else if selectedKeywords.count == 1 {
            selectedGenre?.attributedText = Keyword(rawValue:
                (selectedKeywords.first)!)?.description.styled(.titleHeader)
            
        } else {
            selectedGenre?.attributedText = "Multiple Selected".styled(.titleHeader)
        }
        delegate.updateParameters(with: "keyword", value: keywordParameters)
        tableView?.reloadData()
    }
    
}

extension KeywordOptionTableViewCell: ConfigurableTableViewCellProtocol {
    func configureCell(object: configurableObject) {
        titleLabel?.attributedText = object.styled(.titleHeader)
//        if selectedKeywords.count == 0 {
//            selectedGenre?.attributedText = "None".styled(.titleHeader)
//        } else if selectedKeywords.count == 1 {
//            selectedGenre?.attributedText = Keyword(rawValue:
//                (selectedKeywords.first)!)?.description.styled(.titleHeader)
//        } else {
//            selectedGenre?.attributedText = "Multiple Selected".styled(.titleHeader)
//        }
        expandedIcon?.image = isExpanded ? UIImage(named: "ExpandedIcon") : UIImage(named: "UnExpandedIcon")
    }
}

extension KeywordOptionTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Keyword.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let keywordCell: KeywordTableViewCell =  tableView.dequeueReusableCell(type: KeywordTableViewCell.self)
        keywordCell.configureCell(object: (Keyword(rawValue: indexPath.row)!.description, selectedKeywords.contains(indexPath.row)))
        return keywordCell
    }
}

extension KeywordOptionTableViewCell: UITableViewDelegate {
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

