//
//  Backdrop.swift
//  UBudget
//
//  Created by Sami Hatna on 23/08/2021.
//

import SwiftUI

struct Backdrop: View {
    @State var phase = 0.0
    @State var phase2 = 0.0
    
    var body: some View {
        ZStack (alignment: .center) {
            Wave(amplitude: 5, frequency: 10, phase: phase, percent: 0.93)
                .fill(Color.black)
                .frame(height: UIScreen.main.bounds.height)
                .onAppear {
                    withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                        self.phase = -.pi * 2
                    }
                }
                .onDisappear {
                    withAnimation(.linear(duration: 3)) {
                        self.phase = -.pi * 2
                    }
                }
            Wave(amplitude: 5, frequency: 10, phase: phase2, percent: 0.93)
                .fill(Color.black)
                .opacity(0.5)
                .frame(height: UIScreen.main.bounds.height)
                .onAppear {
                    withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                        self.phase2 = .pi * 2
                    }
                }
        }
    }
}

