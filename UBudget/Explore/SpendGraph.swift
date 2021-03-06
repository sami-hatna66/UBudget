//
//  SpendGraph.swift
//  UBudget
//
//  Created by Sami Hatna on 01/09/2021.
//

import SwiftUI

// View the graph is displayed within, graph itself is implimented as a shape
struct SpendGraph: View {
    @Environment(\.colorScheme) var colorScheme
    
    // Dimensions need to be changed if instance is in PeriodOverView
    @State var isEndScreen: Bool
    
    @Binding var graphData: [SaveData]
    
    var width = UIScreen.main.bounds.width - 60
    var height: CGFloat = 150
    
    @State var highlightedPoint = -1
    
    // Returns the index of epicArray corresponding with the region of the graph the user has tapped in
    func computeHighlight(location: CGFloat) -> Int {
        let leadingSide = (width / CGFloat(graphData.count-1))/2
        var epicArray: [Double] = []
        
        for index in 0..<graphData.count {
            if index == 0 {
                epicArray.append(Double(leadingSide))
            }
            else {
                epicArray.append(Double(leadingSide + (CGFloat((index - 1)) * (width / CGFloat(graphData.count-1)))))
            }
        }
        
        var result = 0
        for index in 0..<epicArray.count {
            if Double(location) > epicArray[index] {
                result = index
            }
        }
        return result
    }
    
    var xOffset: CGFloat {
        return (width/CGFloat(graphData.count-1)) * CGFloat(highlightedPoint) - (width/2)
    }
    
    var yOffset: CGFloat {
        if graphData.count == 0 {
            return 0
        }
        else {
            return (height/2) - (CGFloat(graphData[highlightedPoint].spent * Double(height/(graphData.map { CGFloat($0.spent) }.max() ?? 1))))
        }
    }
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }
    
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.black)
                .frame(
                    width: isEndScreen ? UIScreen.main.bounds.width-20 : UIScreen.main.bounds.width-10,
                    height: 220
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.white, lineWidth: colorScheme == .dark ? 1 : 0)
                )
            
            VStack {
                Text("Weekly Spending")
                    .foregroundColor(.white)
                    .font(Font.custom("DIN", size: 20)).padding(.bottom, -10)
                
                ZStack {
                    // Note: Should change implementation so axis is just part of the graph shape, unfortunately swiftui doesn't let me use different colors in one shape so this implementation will have to do for now
                    Axis(inputData: graphData)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .frame(width: width + 10, height: height + 15)
                    
                    // Graph shape
                    Graph(inputData: graphData, highlightedPoint: $highlightedPoint)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .frame(width: width, height: height)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onEnded {
                                    // On tap/drag, compute which point on the graph should be highlighted
                                    highlightedPoint = computeHighlight(location: $0.location.x)
                                }
                        )
                    
                    // Highlight point
                    Circle()
                        .fill(Color.white).frame(width: 10, height: 10)
                        .offset(x: xOffset, y: highlightedPoint >= 0 ? yOffset : 0)
                        // Hide point at first
                        .opacity(highlightedPoint >= 0 ? 1 : 0)
                    
                    // Text displaying highlighted point's value
                    Text(
                        highlightedPoint >= 0 ? "Week \(String(highlightedPoint + 1))\n\(currencySymbol)\(String(format: "%.2f", graphData[highlightedPoint].spent))" : "")
                        .foregroundColor(.black)
                        .font(Font.custom("DIN", size: 12))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .offset(
                            x: highlightedPoint == 0 ? xOffset + 5 : (highlightedPoint == graphData.count - 1 ? xOffset - 5 : xOffset),
                            y: highlightedPoint >= 0 ? (((height/2)+yOffset) > (height*0.25) ? yOffset - 25 : yOffset + 25) : 0)
                        .padding(3)
                        .opacity(highlightedPoint >= 0 ? 1 : 0)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white)
                                        .offset(
                                            x: highlightedPoint == 0 ? xOffset + 5 : (highlightedPoint == graphData.count - 1 ? xOffset - 5 : xOffset),
                                            y: highlightedPoint >= 0 ? (((height/2)+yOffset) > (height*0.25) ? yOffset - 25 : yOffset + 25) : 0
                                        )
                                        .opacity(highlightedPoint >= 0 ? 1 : 0))
                }
            }
        }
    }
}

