//
//  YesNoWidget.swift
//  UBudget
//
//  Created by Sami Hatna on 27/07/2021.
//

import SwiftUI

struct YesNoWidget: View {
    @Binding var rolloverChoice: Bool
    @State var yOffset = -5
    
    var body: some View {
        ZStack (alignment: .top) {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white)
                .opacity(0.25)
                .frame(width: 100, height: 40)
                .offset(y: CGFloat(yOffset))
            
            VStack {
                Text("Yes")
                    .foregroundColor(.white)
                    .font(Font.custom("DIN", size: 25))
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.05)) {
                            yOffset = -5
                            rolloverChoice = true
                        }
                    }
                
                Text("No")
                    .foregroundColor(.white)
                    .font(Font.custom("DIN", size: 25))
                    .padding(.top, 5)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.05)) {
                            yOffset = 40
                            rolloverChoice = false
                        }
                    }
            }
        }
    }
}

