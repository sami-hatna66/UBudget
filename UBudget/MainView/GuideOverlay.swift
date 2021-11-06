//
//  GuideOverlay.swift
//  UBudget
//
//  Created by Sami Hatna on 07/09/2021.
//

import SwiftUI

struct GuideOverlay: View {
    var body: some View {
        VStack (spacing: 0) {
            Text("Read the guide before\nyou start budgeting")
                .font(Font.custom("DIN", size: 17))
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 170)
                .multilineTextAlignment(.center)
                .padding(.trailing, 20)
            
            Image("Arrow")
                .resizable()
                .frame(width: 30, height: 35)
        }
    }
}

