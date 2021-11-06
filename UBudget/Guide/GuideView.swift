//
//  GuideView.swift
//  UBudget
//
//  Created by Sami Hatna on 03/09/2021.
//

import SwiftUI

// The GuideView is my own reimplimentation of Snapchat/Instagram's story view
struct GuideView: View {
    @Binding var showingGuide: Bool
    
    // Index for which slide is displaying
    @State var index = 0
    
    var body: some View {
        VStack {
            // Initialise progress bars
            HStack {
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 0, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 1, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 2, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 3, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 4, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 5, limit: 5)
            }.frame(width: UIScreen.main.bounds.width - 10).fixedSize()
            
            // Slide content
            Slide(index: $index, showingGuide: $showingGuide, limit: 5)
            
            Spacer()
        }
    }
}

