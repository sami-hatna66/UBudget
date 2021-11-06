//
//  DateStruct.swift
//  UBudget
//
//  Created by Sami Hatna on 01/08/2021.
//

import Foundation

// active required for handling deleted vacancies
struct DateStruct: Codable, Equatable {
    var start: Date
    var end: Date
    var active = true
}
