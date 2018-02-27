//
//  Restaurants.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-09-30.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import Foundation
import ObjectMapper
import MapKit

class Restaurant: Mappable {
    
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    var name: String!
    var isOpen: Bool = true
    var id: String!
    var icon: String!
    var types: [String]!
    var vicinity: String!
    var rating: Double = 0.0
    var priceLevel: Int = PriceRange.unknown.rawValue
    var address: String!
    var website: String! = nil
    
    init() {
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        latitude <- map["geometry.location.lat"]
        longitude <- map["geometry.location.lng"]
        name <- map["name"]
        isOpen <- map["opening_hours.open_now"]
        id <- map["place_id"]
        icon <- map["icon"]
        types <- map["types"]
        vicinity <- map["vicinity"]
        rating <- map["rating"]
        priceLevel <- map["price_level"]
        address <- map["vicinity"]
        
    }
    
    func getRating() -> String {
        return rating == 0.0 ? "Unknown" : "\(rating)"
    }

}
