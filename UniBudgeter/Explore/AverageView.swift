//
//  AverageView.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 09/09/2021.
//

import SwiftUI

struct AverageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var inputData: [SaveData]
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }
    
    var weeklyAverage: Double {
        var count = 0
        var total = 0.0
        for n in 0..<inputData.count {
            total += inputData[n].spent
            count += 1
        }
        return total / Double(count)
    }
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 10).fill(Color.black).overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: colorScheme == .dark ? 1 : 0)
            )
            
            VStack (alignment: .leading, spacing: -5) {
                Text("Average Weekly Spend:").font(Font.custom("DIN", size: 15)).foregroundColor(.white)
                Text(currencySymbol + String(format: "%.2f", weeklyAverage)).font(Font.custom("DIN", size: 40)).minimumScaleFactor(0.5).lineLimit(1).foregroundColor(.white)
            }.padding([.leading, .trailing], 10).padding([.top, .bottom], 5)
        }
    }
}
