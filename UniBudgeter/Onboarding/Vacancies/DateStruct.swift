//
//  DateStruct.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 01/08/2021.
//

import Foundation

struct DateStruct: Codable, Equatable {
    var start: Date
    var end: Date
    var active = true
}
