//
//  StartEndWidget.swift
//  UBudget
//
//  Created by Sami Hatna on 08/09/2021.
//

import SwiftUI

struct StartEndWidget: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var body: some View {
        VStack (spacing: 3) {
            HStack (spacing: 0) {
                Text("Start: ")
                    .foregroundColor(.white)
                    .font(Font.custom("DIN", size: 18))
                    .padding(.leading, 10)
                
                DatePicker("", selection: $startDate, displayedComponents: [.date])
                    .scaleEffect(0.8)
                    .labelsHidden()
                    .background(RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black : Color.white).scaleEffect(0.8))
                Spacer()
            }
            
            HStack (spacing: 0) {
                Text("End: ")
                    .foregroundColor(.white)
                    .font(Font.custom("DIN", size: 18))
                    .padding(.leading, 10)
                
                DatePicker("", selection: $endDate, displayedComponents: [.date])
                    .scaleEffect(0.8)
                    .labelsHidden()
                    .accentColor(Color.black)
                    .background(RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black : Color.white).scaleEffect(0.8))
                    .padding(.leading, 10)
                Spacer()
            }
        }.padding(.leading, 20).padding([.top, .bottom], 7)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
                .frame(width: UIScreen.main.bounds.width - 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: colorScheme == .dark ? 1 : 0)
                )
        )
    }
}

