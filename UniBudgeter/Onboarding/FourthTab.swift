//
//  FourthTab.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 28/07/2021.
//

import SwiftUI

struct FourthTab: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var phase = 0.0
    @State var phase2 = 0.0
    @Binding var start: Date
    @Binding var end: Date
    @Binding var index: Int
    
    var body: some View {
        ZStack (alignment: .center) {
            if index == 3 {
                Backdrop()
            }
            else {
                Wave(amplitude: 5, frequency: 10, phase: 0.0, percent: 0.93).fill(Color.black)
                    .frame(height: UIScreen.main.bounds.height)
            }
            
            VStack (alignment: .leading) {
                Text("When does the budgeting period start and end?").foregroundColor(.white).font(Font.custom("DIN", size: 30)).multilineTextAlignment(.center).padding(.bottom, 20)
                HStack {
                    Text("Start: ").foregroundColor(.white).font(Font.custom("DIN", size: 25))
                    DatePicker("", selection: $start, displayedComponents: [.date])
                        .labelsHidden()
                        .accentColor(Color.black)
                        .background(RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black : Color.white))
                }
                HStack {
                    Text("End: ").foregroundColor(.white).font(Font.custom("DIN", size: 25))
                    DatePicker("", selection: $end, displayedComponents: [.date])
                        .labelsHidden()
                        .accentColor(Color.black)
                        .background(RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black : Color.white))
                        .padding(.leading, 10)
                }
            }.padding().opacity(index == 3 ? 1 : 0).offset(y: CGFloat(index == 3 ? 0 : 75)).animation(.easeInOut(duration: 1), value: index)
        }
    }
}
