//
//  FifthTab.swift
//  UBudget
//
//  Created by Sami Hatna on 30/07/2021.
//

import SwiftUI

struct FifthTab: View {
    @State var phase = 0.0
    @State var phase2 = 0.0
    @Binding var index: Int
    @Binding var dateCollection: [DateStruct]
    
    var body: some View {
        ZStack (alignment: .center) {
            if index == 4 {
                Backdrop()
            }
            else {
                Wave(amplitude: 5, frequency: 10, phase: 0.0, percent: 0.93).fill(Color.black)
                    .frame(height: UIScreen.main.bounds.height)
            }
            
            VStack {
                Text("Are there any dates when you won't be living off your budget?")
                    .foregroundColor(.white).font(Font.custom("DIN", size: 20)).multilineTextAlignment(.center)
                
                VancancyView(dateCollection: $dateCollection, isOnboarding: true)
                
            }.padding().opacity(index == 4 ? 1 : 0).offset(y: CGFloat(index == 4 ? 0 : 75)).animation(.easeInOut(duration: 1), value: index)
        }
    }
}

