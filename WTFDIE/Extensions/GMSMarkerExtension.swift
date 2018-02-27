//
//  GMSMarkerExtension.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2018-02-26.
//  Copyright © 2018 WTFDIE. All rights reserved.
//

import GoogleMaps
import UIKit

enum MarkerType {
    case restauant
    case currentLocation
}

extension GMSMarker {
    
    func style(with type: MarkerType) {
        self.appearAnimation = GMSMarkerAnimation.pop
    }
}
