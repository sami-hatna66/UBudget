//
//  RemaningView.swift
//  UBudget
//
//  Created by Sami Hatna on 10/09/2021.
//

import SwiftUI

struct RemaningView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var inputData: [SaveData]
    
    var total = UserDefaults(suiteName: "group.com.my.app.unibudgeter")?.double(forKey: "total") ?? 0.0
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: colorScheme == .dark ? 1 : 0)
                )
            
            VStack (alignment: .leading, spacing: -5) {
                Text("Remaining Budget:")
                    .font(Font.custom("DIN", size: 15))
                    .foregroundColor(.white)
                Text(currencySymbol + String(format: "%.2f", total))
                    .font(Font.custom("DIN", size: 40))
                    .lineLimit(1).foregroundColor(.white)
            }.padding([.leading, .trailing], 10).padding([.top, .bottom], 5)
        }
    }
}

