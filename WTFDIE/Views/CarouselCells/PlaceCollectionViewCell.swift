//
//  PlaceCollectionViewCell.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-26.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit
import MapKit

class PlaceCollectionViewCell: UICollectionViewCell {

    typealias configurableObject = (Restaurant, CLLocation)
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeOpenView: UIView!
    @IBOutlet weak var placeOpenLabel: UILabel!
    @IBOutlet weak var priceImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var delegate: showDetailDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 15.0
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        placeNameLabel.adjustsFontSizeToFitWidth = true
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.placeOpenView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            self.placeOpenView.layer.mask = maskLayer
            self.placeOpenView.layer.masksToBounds = true
        }
        self.layoutIfNeeded()
        
        self.clipsToBounds = false
    }
    @IBAction func showInfo(_ sender: Any) {
        delegate.showDetail()
    }
}

extension PlaceCollectionViewCell: ConfigurableCollectionViewCellProtocol {
    func configureCell(object: configurableObject) {
        placeNameLabel.text = "\(object.0.name ?? "")\n\n\(object.0.address ?? "")"
        placeOpenLabel.attributedText = object.0.isOpen ? "Open".styled(.labelWhite) : "Closed".styled(.labelWhite)
        
        distanceLabel.attributedText = String(format: "%.2f meters", object.1.distance(from: CLLocation(latitude: object.0.latitude, longitude: object.0.longitude))).styled(.labelWhite)
        //placeAddressLabel.attributedText =  object.0.address.styled(.labelWhite)
        placeOpenView.backgroundColor = object.0.isOpen ? UIColor(.malachiteGreen) : UIColor(.roseWhite)
        
        priceLabel.attributedText = PriceRange(rawValue: object.0.priceLevel)?.dollarValue.styled(.titleHeader)
        ratingLabel.attributedText = (object.0.getRating()).styled(.titleHeader)
    }
}
