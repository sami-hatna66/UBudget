//
//  BudgetVisual.swift
//  UBudget
//
//  Created by Sami Hatna on 27/07/2021.
//

import SwiftUI

struct BudgetVisual: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var weekTotal: [Double]
    @State var yearTotal: Double
    
    var percent: Double {
        if weekTotal[0] == 0 {
            return 0
        }
        else {
            return weekTotal[1]/weekTotal[0]
        }
    }
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }
    
    @Binding var deductibleList: [String]
    
    @State var textOpacity = 0.0
    
    @State var phase = 0.0
    @State var phase2 = 0.0
    @State var waveHeight = CGFloat(300)
    
    var formatter: NumberFormatter {
        let f  = NumberFormatter()
        f.usesSignificantDigits = true
        f.maximumSignificantDigits = 2
        f.minimumSignificantDigits = 1
        return f
    }
    
    var body: some View {
            ZStack (alignment: .center) {
                Wave(amplitude: 5, frequency: 10, phase: phase, percent: percent)
                    .frame(height: waveHeight)
                    .clipShape(Circle())
                    .overlay(Circle().stroke())
                    .onAppear {
                        withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                            self.phase = -.pi * 2
                        }
                    }
                
                Wave(amplitude: 5, frequency: 10, phase: phase2, percent: percent)
                    .fill(colorScheme == .dark ? Color.white : Color.black).opacity(0.5)
                    .frame(height: waveHeight)
                    .clipShape(Circle())
                    .onAppear {
                        withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                            self.phase2 = .pi * 2
                        }
                    }
                
                Text(currencySymbol + String(format: "%.2f", weekTotal[1]))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .font(Font.custom("DIN", size: 70))
                    .frame(width: 280)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                Wave(amplitude: 5, frequency: 10, phase: phase, percent: percent)
                    .fill(colorScheme == .dark ? Color.black : Color.white)
                    .frame(height: waveHeight)
                    .clipShape(Circle())
                    .onAppear {
                        withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                            self.phase = -.pi * 2
                        }
                    }.mask(Text(currencySymbol + String(format: "%.2f", weekTotal[1]))
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .font(Font.custom("DIN", size: 70)))
                    .frame(width: 280)
                    .minimumScaleFactor(0.5).lineLimit(1)
                
                GeometryReader { g in
                    VStack (alignment: .leading) {
                        ForEach(deductibleList.indices, id: \.self) { index in
                            Text(deductibleList[index])
                                .foregroundColor(.red)
                                .font(Font.custom("DIN", size: 15))
                        }
                    }.offset(x: 10, y: UIScreen.main.bounds.height/15)
                        .opacity(textOpacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.5)) {
                                textOpacity = 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeIn(duration: 0.5)) {
                                textOpacity = 0
                                deductibleList = []
                            }
                        }
                    }
                }
                
            }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "previousDate")
        }
    }
}
