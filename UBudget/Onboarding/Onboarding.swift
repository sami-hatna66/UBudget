//
//  SplashScreen.swift
//  UBudget
//
//  Created by Sami Hatna on 27/07/2021.
//

import SwiftUI

struct Onboarding: View {
    @State var tabIndex = -1
    @State var totalAmount = "0"
    @State var start = Date()
    @State var end = Date()
    @State var dateCollection: [DateStruct] = []
    @State var deductibleCollection: [DeductibleStruct] = []
    
    var body: some View {
        TabView(selection: $tabIndex,
            content:  {
                FirstTab(index: $tabIndex)
                    .tag(0)
                SecondTab(index: $tabIndex, textFieldValue: $totalAmount)
                    .tag(1)
                ThirdTab(index: $tabIndex, deductibleCollection: $deductibleCollection)
                    .tag(2)
                FourthTab(start: $start, end: $end, index: $tabIndex)
                    .tag(3)
                FifthTab(index: $tabIndex, dateCollection: $dateCollection)
                    .tag(4)
                SixthTab(index: $tabIndex, totalAmount: $totalAmount, start: $start, end: $end, dateCollection: $dateCollection, deductibleCollection: $deductibleCollection)
                    .tag(5)
            }).background(Color.white.edgesIgnoringSafeArea(.all))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    tabIndex = 0
                }
            }
            .tabViewStyle(PageTabViewStyle())
    }
}
