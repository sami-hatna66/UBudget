//
//  DeductibleStruct.swift
//  UBudget
//
//  Created by Sami Hatna on 24/08/2021.
//

import Foundation

struct DeductibleStruct: Codable {
    var name: String
    var amount: Double
    var interval: String
    var active = true
}
