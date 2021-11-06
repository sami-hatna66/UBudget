//
//  LineGraph.swift
//  UBudget
//
//  Created by Sami Hatna on 01/09/2021.
//

import Foundation
import SwiftUI

// Graph shape - takes input data of type SaveData and plots a fully scaleable line chart
struct Graph: Shape {
    var inputData: [SaveData]
    
    @Binding var highlightedPoint: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        // scale values to frame of shape
        let multiplier = rect.height / (inputData.map { CGFloat($0.spent) }.max() ?? 1)
        
        for index in 0 ..< inputData.count {
            
            let amount = inputData[index].spent
            
            // plot values 
            if index == 0 {
                path.move(to: CGPoint(
                                    x: (rect.width/CGFloat(inputData.count-1)) * CGFloat(index),
                                    y: rect.height - (CGFloat(amount * Double(multiplier)))
                            ))
            }
            else {
                let x = (rect.width/CGFloat(inputData.count-1)) * CGFloat(index)
                let y = rect.height - (CGFloat(amount * Double(multiplier)))
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return path
    }
}
