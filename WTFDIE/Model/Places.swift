//
//  Places.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-09-30.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import Foundation
import ObjectMapper

class Places: Mappable {
    var results: [Restaurant]!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        results <- map["results"]
    }
    
}
