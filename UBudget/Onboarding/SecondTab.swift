//
//  SecondTab.swift
//  UBudget
//
//  Created by Sami Hatna on 27/07/2021.
//

import SwiftUI

struct SecondTab: View {
    @State var phase = 0.0
    @State var phase2 = 0.0
    @Binding var index: Int
    
    @Binding var textFieldValue: String
    
    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol!
    }
    
    var body: some View {
        ZStack (alignment: .center) {
            if index == 1 {
                Backdrop()
            }
            else {
                Wave(amplitude: 5, frequency: 10, phase: 0.0, percent: 0.93)
                    .fill(Color.black)
                    .frame(height: UIScreen.main.bounds.height)
            }
            
            VStack {
                Text("Could you tell us how much money you've set aside for this budgeting period")
                    .foregroundColor(.white)
                    .font(Font.custom("DIN", size: 25))
                    .multilineTextAlignment(.center)
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .foregroundColor(.white)
                        .frame(width: 330, height: 35)
                    HStack (spacing: 1) {
                        Text(currencySymbol)
                            .foregroundColor(.black)
                            .font(Font.custom("DIN", size: 20))
                            .font(Font.custom("DIN", size: 20))
                        TextField("", text: $textFieldValue)
                            .foregroundColor(.black)
                            .accentColor(.black)
                            .background(Color.white)
                            .frame(width: 300 - currencySymbol.widthOfString(usingFont: UIFont(name: "DIN", size: 20)!))
                            .keyboardType(.decimalPad).font(Font.custom("DIN", size: 20))
                    }
                }
            }
            .padding()
            .opacity(index == 1 ? 1 : 0)
            .offset(y: CGFloat(index == 1 ? 0 : 75))
            .animation(.easeInOut(duration: 1), value: index)

        }
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
            )
        }
    }
}

