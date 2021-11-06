//
//  Axis.swift
//  UBudget
//
//  Created by Sami Hatna on 01/09/2021.
//

import Foundation
import SwiftUI

// Axis for graph
// Separate from graph because I want it to be a different color and there is no way to achieve that with them being in the same shape
struct Axis: Shape {
    var inputData: [SaveData]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: 0))
        // Add axis lines
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 5))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 5))
        
        // Plot axis ticks
        for n in 0...inputData.count-1 {
            var xOffset = CGFloat(0.0)
            if n == 0 {
                xOffset = (rect.width/CGFloat(inputData.count-1)) * CGFloat(n) + 5
            }
            else {
                xOffset = (rect.width/CGFloat(inputData.count-1)) * CGFloat(n)
            }
            path.move(to: CGPoint(x: xOffset, y: rect.maxY - 5))
            path.addLine(to: CGPoint(x: xOffset, y: rect.maxY))
        }
        
        return path
    }
}
