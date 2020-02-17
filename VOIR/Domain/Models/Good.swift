//
//  Good.swift
//  VOIR
//
//  Created by Andrew Krotov on 26/07/2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import Foundation

public struct Good {
    let id: String
    let image: String
    let currencyID: String
    let price: String
    let name: String
    let vendor: String
    let color: String?
}

extension Good: Codable {
    public enum CodingKeys: String, CodingKey {
        case id = "ID"
        case image
        case currencyID = "currency_id"
        case price
        case name
        case vendor
        case color
    }
}
