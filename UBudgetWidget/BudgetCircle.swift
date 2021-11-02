//
//  BudgetCircle.swift
//  UBudget
//
//  Created by Sami Hatna on 25/09/2021.
//

import SwiftUI

struct BudgetCircle: View {
    @Environment(\.colorScheme) var colorScheme
    
    var currencySymbol: String
    
    var total: Double
    var spend: Double
    
    var body: some View {
        ZStack {
            Text(currencySymbol + String(format: "%.2f", spend)).foregroundColor(colorScheme == .dark ? .white : .black).font(Font.custom("DIN", size: 60)).frame(width: 70).lineLimit(1).minimumScaleFactor(0.1)
            
            Circle()
                .stroke(colorScheme == .dark ? Color.white : Color.black, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .opacity(0.1)
                .frame(width: 95, height: 95)
            
            Circle()
                .rotation(.degrees(-90))
                .trim(from: 0, to: spend/total)
                .stroke(colorScheme == .dark ? Color.white : Color.black, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .frame(width: 95, height: 95)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }
}
