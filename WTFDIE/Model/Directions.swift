//
//  Directions.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2018-02-18.
//  Copyright © 2018 WTFDIE. All rights reserved.
//

import Foundation
import ObjectMapper

class Directions: Mappable {
    
    var routes: [Route]!
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        routes <- map["routes"]
    }
}
