//
//  DeductiblesView.swift
//  UBudget
//
//  Created by Sami Hatna on 23/08/2021.
//

import SwiftUI

struct DeductiblesView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var deductibleCollection: [DeductibleStruct]
    @Binding var showingSheet: Bool
    
    var isOnboarding: Bool
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            ScrollView {
                ForEach(deductibleCollection.indices, id: \.self) { index in
                    if deductibleCollection[index].active {
                        DeductibleWidget(deductibleCollection: $deductibleCollection, index: index)
                    }
                }
            }.padding(10)
            .frame(width: UIScreen.main.bounds.width - 30, height: 300)
            .background(
                RoundedRectangle(cornerRadius: 10).fill(isOnboarding ? Color.gray : Color.black).opacity(isOnboarding ? 0.25 : 1).overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: (isOnboarding == false && colorScheme == .dark) ? 1 : 0)
                )
            )
            Button(action: {
                //deductibleCollection.append(DeductibleStruct(name: "Pog", amount: 5.0, interval: "POG"))
                showingSheet = true
            }) {
                Image(systemName: "plus.circle.fill").resizable().frame(width: 50, height: 50).foregroundColor(.white).offset(x: 13, y: 13).overlay(Circle().stroke(Color.black, lineWidth: 1).offset(x: 13, y: 13))
            }
        }
    }
}
