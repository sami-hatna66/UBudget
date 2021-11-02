//
//  GuideView.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 03/09/2021.
//

import SwiftUI

struct GuideView: View {
    @Binding var showingGuide: Bool
    
    @State var index = 0
    var views = ["View1", "View2", "View3", "View4", "View5"]
    
    var body: some View {
        VStack {
            HStack {
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 0, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 1, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 2, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 3, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 4, limit: 5)
                ProgressBar(showingGuide: $showingGuide, index: $index, tag: 5, limit: 5)
            }.frame(width: UIScreen.main.bounds.width - 10).fixedSize()
            
            Slide(index: $index, showingGuide: $showingGuide, limit: 5)
            
            Spacer()
        }
    }
}

