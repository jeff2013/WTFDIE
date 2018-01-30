//
//  Font.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-02.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import UIKit

extension UIFont{
    enum FontBook: String {
        case helveticaNeueLight     = "HelveticaNeue-Light"
        case helveticaNeueMedium    = "HelveticaNeue-Medium"
        case helveticaNeue          = "HelveticaNeue"
        case helveticaNeueBold      = "HelveticaNeue-Bold"
        
    }
    
    convenience init(_ appFont: FontBook, size fontSize: CGFloat){
        self.init(name: appFont.rawValue, size: fontSize)!
    }
}
