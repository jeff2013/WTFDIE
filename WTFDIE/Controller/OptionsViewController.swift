//
//  OptionsViewController.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-08.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

protocol DataChangedDelegate {
    func updateParameters(with key: String, value: String)
}

enum Options: Int {
    case searchType
    case priceRange
    case distance
    case genre
    case count
}

enum PriceRange: Int {
    case inexpensive
    case moderate
    case pricey
    case highEnd
    case unknown
    
    //Varies per region
    var dollarValue: String {
        switch self {
        case .inexpensive:
            return "Under $10"
        case .moderate:
            return "$11-30"
        case .pricey:
            return "$31-60"
        case .highEnd:
            return "Above $60"
        case .unknown:
            return "Unknown"
        }
    }
    
    //minprice and maxprice (optional) — Restricts results to only those places within the specified range. Valid values range between 0 (most affordable) to 4 (most expensive), inclusive. The exact amount indicated by a specific value will vary from region to region.
    var minMaxPrice: (String, String) {
        switch self {
        case .inexpensive:
            return ("0", "1")
        case .moderate:
            return ("1", "2")
        case .pricey:
            return ("2", "3")
        case .highEnd:
            return ("3", "4")
        case .unknown:
            return ("0", "4")
        }
    }
}

class OptionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var expandedRows = Set<Int>()
    
    var parameters: Dictionary<String, String> = Dictionary<String, String>()
    
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        title = "Options"
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 200
        
        //TEMP
        //location = CLLocationCoordinate2D(latitude: 49.288806, longitude: -123.122776)
        
        //initialize settings with default values
        parameters.updateValue("restaurant", forKey: "type")
        parameters.updateValue("1", forKey: "minprice")
        parameters.updateValue("2", forKey: "maxprice")
        parameters.updateValue("5000", forKey: "radius")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func destinationRequested(_ sender: Any) {
        if let location = location {
            SVProgressHUD.show()
            GooglePlacesService.getNearbyRestaurants(location: location, radius: parameters["radius"] ?? "", type: parameters["type"] ?? "", keyword: parameters["keyword"] ?? "") { (result) in
                SVProgressHUD.dismiss()
                if result.error == nil {
                    if let places = result.value?.results {
                        let destViewController: ResultsViewController = OptionsViewController.instanceFromStoryboard(storyboard: .resultsViewController)
                        destViewController.location = location
                        destViewController.places = places
                        self.navigationController?.pushViewController(destViewController, animated: true)
                    }
                } else {
                    SVProgressHUD.showError(withStatus: "Failed retreiving results")
                }
            }
        }
    }
}

extension OptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? ExpandableUITableViewCell
            else { return }
        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        cell.isExpanded = !cell.isExpanded
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

extension OptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Options.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Options(rawValue: indexPath.row)! {
        case .searchType:
            let searchTypeCell: SearchTypeTableViewCell =  tableView.dequeueReusableCell(type: SearchTypeTableViewCell.self)
            searchTypeCell.configureCell(object: "Type")
            searchTypeCell.isExpanded = self.expandedRows.contains(indexPath.row)
            searchTypeCell.delegate = self
            return searchTypeCell
        case .priceRange:
            let priceRangeCell: PriceSelectionTableViewCell = tableView.dequeueReusableCell(type: PriceSelectionTableViewCell.self)
            priceRangeCell.configureCell(object: PriceRange.moderate)
            priceRangeCell.isExpanded = true
            priceRangeCell.delegate = self
            return priceRangeCell
        case .distance:
            let rangeCell: DistanceOptionTableViewCell = tableView.dequeueReusableCell(type: DistanceOptionTableViewCell.self)
            rangeCell.isExpanded = true
            rangeCell.delegate = self
            return rangeCell
        case .genre:
            let keywordOptionCell: KeywordOptionTableViewCell = tableView.dequeueReusableCell(type: KeywordOptionTableViewCell.self)
            keywordOptionCell.configureCell(object: "Keyword")
            keywordOptionCell.isExpanded = self.expandedRows.contains(indexPath.row)
            keywordOptionCell.delegate = self
            return keywordOptionCell
        default:
            return UITableViewCell()
        }
    }
}

extension OptionsViewController: DataChangedDelegate {
    func updateParameters(with key: String, value: String) {
        parameters.updateValue(value, forKey: key)
    }
}

