//
//  Wave.swift
//  UBudget
//
//  Created by Sami Hatna on 27/07/2021.
//

import Foundation
import SwiftUI

struct Wave: Shape {
    var amplitude: Double
    var frequency: Double
    var phase: Double
    var percent: Double
    
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        if percent != 0 && percent != 1 {
            let space = Double(rect.maxX) / frequency
            
            path.move(to: CGPoint(x: 0, y: rect.maxY * (1-CGFloat(percent))))
            
            for x in stride(from: 0, to: rect.maxX+1, by: 1) {
                let relativeX = Double(x) / space
                let sine = sin(relativeX + phase)
                let y = amplitude * sine + Double(rect.maxY * (1-CGFloat(percent)))
                path.addLine(to: CGPoint(x: CGFloat(x), y: CGFloat(y)))
            }
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY * (1-CGFloat(percent))))
        }
        if percent == 1 {
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        }

        return Path(path.cgPath)
    }
}

