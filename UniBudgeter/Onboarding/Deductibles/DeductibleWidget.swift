//
//  DeductibleWidget.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 23/08/2021.
//

import SwiftUI

struct DeductibleWidget: View {
    @Binding var deductibleCollection: [DeductibleStruct]
    @State var index: Int
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }
    
    var body: some View {
        HStack {
            Text(deductibleCollection[index].name).lineLimit(1).foregroundColor(.white)
            Spacer()
            Text(currencySymbol + String(format: "%.2f", deductibleCollection[index].amount)).foregroundColor(.white)
                .padding(.trailing, 10)
            Text(deductibleCollection[index].interval).foregroundColor(.white).padding(.trailing, 10)
            Button(action: {
                deductibleCollection[index].active = false
            }) {
                Image(systemName: "trash.fill").foregroundColor(.white)
            }
        }.frame(maxWidth: .infinity).padding(.leading, 10).padding(.trailing, 10).padding(.top, 5).padding(.bottom, 5)
    }
}
