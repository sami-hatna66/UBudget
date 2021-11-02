//
//  BubbleOverlay.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 10/09/2021.
//

import SwiftUI

struct BubbleOverlay: View {
    var body: some View {
        VStack (spacing: 0) {
            Text("Your weekly budget").font(Font.custom("DIN", size: 17)).fixedSize(horizontal: false, vertical: true).frame(width: 170)
                .multilineTextAlignment(.center).padding(.leading, 20)
            Image("Arrow").resizable().frame(width: 30, height: 35).rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }
}
