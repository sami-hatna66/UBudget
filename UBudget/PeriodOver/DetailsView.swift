//
//  DetailsView.swift
//  UBudget
//
//  Created by Sami Hatna on 23/10/2021.
//

import SwiftUI

// Displays graph of user's spending + summary statistics
// For use on end screen shown when budgeting period concludes
struct DetailsView: View {
    @State var graphData: [SaveData]
    
    var remainingMoney = UserDefaults(suiteName: "group.com.my.app.unibudgeter")?.double(forKey: "total") ?? 0.0
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }
    
    var amountSpent = (UserDefaults(suiteName: "group.com.my.app.unibudgeter")?.double(forKey: "totalOverall") ?? 0.0) - (UserDefaults(suiteName: "group.com.my.app.unibudgeter")?.double(forKey: "total") ?? 0.0)
    
    var weeklyAverage: Double {
        var count = 0
        var total = 0.0
        for n in 0..<graphData.count {
            total += graphData[n].spent
            count += 1
        }
        return total / Double(count)
    }
    
    var body: some View {
        VStack {
            if graphData.count > 1 {
                SpendGraph(isEndScreen: true, graphData: $graphData).padding(.bottom, 10)
            }
            
            HStack (alignment: .bottom) {
                Text(currencySymbol + String(remainingMoney)).font(Font.custom("DIN", size: 30))
                Text("remaining").font(Font.custom("DIN", size: 20)).padding(.bottom, 3)
                Spacer()
            }.padding(.leading, 15)
            
            HStack (alignment: .bottom) {
                Text(currencySymbol + String(format: "%.2f", amountSpent)).font(Font.custom("DIN", size: 30))
                Text("spent").font(Font.custom("DIN", size: 20)).padding(.bottom, 3)
                Spacer()
            }.padding(.leading, 15)
            
            HStack (alignment: .bottom) {
                Text(currencySymbol + String(format: "%.2f", weeklyAverage)).font(Font.custom("DIN", size: 30))
                Text("average weekly spend").font(Font.custom("DIN", size: 20)).padding(.bottom, 3)
                Spacer()
            }.padding(.leading, 15)
        }.padding(5).foregroundColor(.black).background(
            RoundedRectangle(cornerRadius: 15).fill(Color.white).frame(width: UIScreen.main.bounds.width - 10)
        )
    }
}

