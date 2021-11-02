//
//  SaveStruct.swift
//  UBudget
//
//  Created by Sami Hatna on 30/08/2021.
//

import Foundation

struct SaveData: Codable {
    var start: Date
    var end: Date
    var total: Double
    var spent: Double
}
