//
//  Slide.swift
//  UBudget
//
//  Created by Sami Hatna on 03/09/2021.
//

import SwiftUI

struct Slide: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var index: Int
    @Binding var showingGuide: Bool
    
    var textOptions = [
        "This bubble shows your weekly budget. As you spend your money it will gradually empty out.\n",
        "Every time you open the app, any recurring payments which have been applied will be displayed in red.\n",
        "Press this button to subtract any expenses from your weekly budget.\n\n",
        "Press this button to add any extra income to your weekly budget.\n\n",
        "Visit the explore tab to find graphs and stats about your spending habits or read our blog.\n",
        "Open the settings tab to change the start/end dates of your budgeting period, edit off-budget dates and add/delete recurring payments."
    ]
    
    var imageOptions = ["GuideSlide1", "GuideSlide2", "GuideSlide3", "GuideSlide4", "GuideSlide5", "GuideSlide6"]
    
    @State var contentsOpacity = 1.0
    
    var limit: Int
    
    var body: some View {
        ZStack {
            Rectangle().fill(colorScheme == .dark ? Color.black : Color.white)
            VStack {
                // Slide content changes according to index
                Image(imageOptions[index]).resizable()
                    .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40)
                Text(textOptions[index])
                    .font(Font.custom("DIN", size: 20)).multilineTextAlignment(.center).padding()
            }
        }.gesture(
            // Handles user taps
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded {
                    // If tap is in right two thirds of width, move to next slide (or end story if on last slide)
                    if $0.location.x > UIScreen.main.bounds.width/3 {
                        if index < limit {
                            index += 1
                        }
                        else {
                            showingGuide = false
                        }
                    }
                    // If tap is on left third, go back one slide
                    else {
                        if index > 0 {
                            index -= 1
                        }
                    }
                }
        )
    }
}
