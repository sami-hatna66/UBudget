//
//  AnimateTick.swift
//  UBudget
//
//  Created by Sami Hatna on 28/07/2021.
//

import SwiftUI

struct AnimateTick: View {
    
    var height: CGFloat
    var width: CGFloat
    @Binding var index: Int

    @State private var percentage: CGFloat = .zero
    
    var body: some View {
        Tick()
            .trim(from: 0, to: index == 5 ? 1 : 0)
            .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            .animation(.linear(duration: 1.5))
            .frame(width: 100, height: 100)
    }
}

struct Tick: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.move(to: CGPoint(x: rect.width/4, y: rect.height*0.6))
        path.addLine(to: CGPoint(x: rect.width*0.4, y: rect.height*0.8))
        path.addLine(to: CGPoint(x: rect.width*0.75, y: rect.height*0.25))

        return path
    }
}
