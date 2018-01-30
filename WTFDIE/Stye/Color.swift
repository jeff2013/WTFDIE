//
//  Color.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-02.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

extension UIColor {
    
    enum Color: UInt32 {
        case white         = 0xffffff
        case bluish        = 0x2278cf
        case darkSkyBlue   = 0x2b98f0
        case pinkishGrey   = 0xbdbdbd
        case warmGrey      = 0x757575
        case lightGrey     = 0xBCBCBC
        case black         = 0x000000
        case watermelon    = 0xfc5457
        case whiteTwo      = 0xfbfbfb
        case whiteThree    = 0xececec
        case dark          = 0x141823
        case darkTwo       = 0x212531
        case lightBlack    = 0x212121
        case warmGreyThree = 0x747474
        case malachiteGreen = 0x6BF178
        case azureBlue     = 0x35A7FF
        case roseWhite     = 0xFF5964
        case gargoyleYellow = 0xFFE74C
        case ufoGreen      = 0x4CDF64
        
        
        
    }
    
    convenience init(_ color: Color, alpha: CGFloat = 1.0) {
        let mask = 0x000000FF
        let hex = color.rawValue
        
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
