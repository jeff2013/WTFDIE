
//
//  Route.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2018-02-19.
//  Copyright © 2018 WTFDIE. All rights reserved.
//

import Foundation
import ObjectMapper

class Route: Mappable {
    
    var points: String!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        points <- map["overview_polyline.points"]
    }
}
