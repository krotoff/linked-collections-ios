//
//  String.swift
//  VOIR
//
//  Created by Andrew Krotov on 26/07/2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import Foundation

public extension String {
    var currencySymbol: String? {
        let displayName = NSLocale(localeIdentifier: self).displayName(forKey: .currencySymbol, value: self)
        if displayName == self {
            return NSLocale(localeIdentifier: self.dropLast() + "_en")
                .displayName(forKey: .currencySymbol, value: self)
        }
        return displayName
    }
}
