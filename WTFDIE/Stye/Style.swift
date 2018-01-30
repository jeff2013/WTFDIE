//
//  Style.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-02.
//  Copyright © 2017 WTFDIE. All rights reserved.
//
import UIKit
import TextAttributes

indirect enum Style: Int {
    
    case navBarHeader
    case titleHeader
    case cellTitle
    case labelWhite
    case headerLeft
    case labelGreyLeft
    case labelWhiteCenter
}

class StyleGuide {
    class func attributes(_ style: Style) -> TextAttributes {
        switch style {
        case .navBarHeader:
            return TextAttributes()
                .font(UIFont(.helveticaNeueMedium, size: 17))
                .foregroundColor(UIColor(.whiteTwo))
                .backgroundColor(UIColor(.bluish))
                .alignment(.center)
        case .titleHeader:
            return TextAttributes()
                .font(UIFont(.helveticaNeueMedium, size: 17))
                .foregroundColor(UIColor(.warmGrey))
                .alignment(.center)
        case .cellTitle:
            return TextAttributes()
                .font(UIFont(.helveticaNeueMedium, size: 17))
                .foregroundColor(UIColor(.warmGrey))
                .alignment(.left)
        case .labelWhite:
            return TextAttributes()
                .font(UIFont(.helveticaNeueMedium, size: 17))
                .foregroundColor(UIColor(.white))
                .alignment(.left)
        case .headerLeft:
            return TextAttributes()
                .font(UIFont(.helveticaNeueMedium, size: 30))
                .foregroundColor(UIColor(.azureBlue))
                .alignment(.left)
        case .labelGreyLeft:
            return TextAttributes()
                .font(UIFont(.helveticaNeueMedium, size: 17))
                .foregroundColor(UIColor(.warmGrey))
                .alignment(.left)
        case .labelWhiteCenter:
            return TextAttributes()
                .font(UIFont(.helveticaNeueMedium, size: 17))
                .foregroundColor(UIColor(.white))
                .alignment(.center)
        }
    }
}


extension String{
    func styled(_ style: Style) -> NSAttributedString{
        return  NSAttributedString(string: self, attributes: StyleGuide.attributes(style))
    }
}
    
