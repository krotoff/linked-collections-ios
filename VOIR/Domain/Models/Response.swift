//
//  Response.swift
//  VOIR
//
//  Created by Andrew Krotov on 26/07/2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import Foundation

public struct Response {
    let products: [Good]
}

extension Response: Codable {
    public enum CodingKeys: String, CodingKey {
        case products
    }
}
