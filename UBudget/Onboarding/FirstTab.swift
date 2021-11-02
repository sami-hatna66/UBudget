//
//  FirstTab.swift
//  UBudget
//
//  Created by Sami Hatna on 27/07/2021.
//

import SwiftUI

struct FirstTab: View {
    @Binding var index: Int
    
    var body: some View {
        ZStack (alignment: .center) {
            if index == 0 {
                Backdrop()
            }
            else {
                Wave(amplitude: 5, frequency: 10, phase: 0.0, percent: 0.93).fill(Color.black)
                    .frame(height: UIScreen.main.bounds.height)
            }
            
            VStack (alignment: .center) {
                Text("Hello there!").foregroundColor(.white).font(Font.custom("DIN Bold", size: 60))
                Text("Before you start budgeting with UBudget, we'd like to gather some information about your budgeting needs").foregroundColor(.white).font(Font.custom("DIN", size: 20)).multilineTextAlignment(.center)
            }.padding().opacity(index == 0 ? 1 : 0).offset(y: CGFloat(index == 0 ? 0 : 75)).animation(.easeInOut(duration: 1), value: index)
        }
    }
}
