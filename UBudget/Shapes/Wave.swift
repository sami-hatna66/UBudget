//
//  Wave.swift
//  UBudget
//
//  Created by Sami Hatna on 27/07/2021.
//

import Foundation
import SwiftUI

// Wave implemented as a sine wave
struct Wave: Shape {
    // Height of wave
    var amplitude: Double
    // Number of waves produced
    var frequency: Double
    // Offset
    var phase: Double
    // Percentage for budget visual
    var percent: Double
    
    // animatableData lets us define how phase applies to the wave's animation
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    
    // Function for drawing shape using path
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        if percent != 0 && percent != 1 {
            // Get available space per individual wave
            let space = Double(rect.maxX) / frequency
            
            path.move(to: CGPoint(x: 0, y: rect.maxY * (1-CGFloat(percent))))
            
            // Draw sine wave
            for x in stride(from: 0, to: rect.maxX+1, by: 1) {
                let relativeX = Double(x) / space
                let sine = sin(relativeX + phase)
                let y = amplitude * sine + Double(rect.maxY * (1-CGFloat(percent)))
                path.addLine(to: CGPoint(x: CGFloat(x), y: CGFloat(y)))
            }
            
            // Fill out rest of shape
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY * (1-CGFloat(percent))))
        }
        
        // If budget is 100% full then don't bother drawing wave
        if percent == 1 {
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        }

        return Path(path.cgPath)
    }
}

