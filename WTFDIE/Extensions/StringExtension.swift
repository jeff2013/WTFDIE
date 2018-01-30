//
//  StringExtension.swift
//  WTFDIE
//
//  Created by Jeff Chang on 2017-10-02.
//  Copyright © 2017 WTFDIE. All rights reserved.
//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized(with comment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
    func localized(args: CVarArg...) -> String {
        return withVaList(args) {
            NSString(format: self.localized, locale: Locale.current, arguments: $0) as String
        }
    }
}
