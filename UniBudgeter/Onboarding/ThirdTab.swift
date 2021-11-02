//
//  ThirdTabTemp.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 23/08/2021.
//

import SwiftUI

struct ThirdTab: View {
    @Binding var index: Int
    @State var infoOpacity = 0.0
    @State var blurRadius = 0.0
    @Binding var deductibleCollection: [DeductibleStruct]
    @State var showingSheet = false
    
    var body: some View {
        ZStack {
            ZStack (alignment: .center) {
                if index == 2 {
                    Backdrop()
                }
                else {
                    Wave(amplitude: 5, frequency: 10, phase: 0.0, percent: 0.93).fill(Color.black)
                        .frame(height: UIScreen.main.bounds.height)
                }
                
                VStack {
                    Text("Please input any recurring payments which you need to budget for")
                        .foregroundColor(.white).font(Font.custom("DIN", size: 20)).multilineTextAlignment(.center)
                    DeductiblesView(deductibleCollection: $deductibleCollection, showingSheet: $showingSheet, isOnboarding: true)
                }.padding().opacity(index == 2 ? 1 : 0).offset(y: CGFloat(index == 2 ? 0 : 75)).animation(.easeInOut(duration: 1), value: index)
                
                Button(action: {
                    withAnimation(.linear(duration: 0.5)) {
                        infoOpacity = 1
                        blurRadius = 5
                    }
                }) {
                    Image(systemName: "questionmark.circle.fill").resizable().frame(width: 40, height: 40).foregroundColor(.white)
                }.opacity(index == 2  ? 1 : 0).offset(x: UIScreen.main.bounds.width/2 - 50, y: index == 2 ? UIScreen.main.bounds.height / 2 - 100 : UIScreen.main.bounds.height / 2 - 25).animation(.easeInOut(duration: 1), value: index)
            }
            .sheet(isPresented: $showingSheet) {
                AddDeductible(deductibleCollection: $deductibleCollection, showingSheet: $showingSheet)
            }
            .blur(radius: CGFloat(blurRadius))
            .onTapGesture {
                withAnimation(.linear(duration: 0.5)) {
                    infoOpacity = 0
                    blurRadius = 0
                }
            }
            
            InfoView().opacity(infoOpacity)
        }
    }
}
