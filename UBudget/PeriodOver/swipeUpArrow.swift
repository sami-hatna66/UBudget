//
//  swipeUpArrow.swift
//  UBudget
//
//  Created by Sami Hatna on 25/10/2021.
//

import SwiftUI

struct swipeUpArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width/2, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))

        return path
    }
}

