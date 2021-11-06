//
//  ProgressBar.swift
//  UBudget
//
//  Created by Sami Hatna on 03/09/2021.
//

import SwiftUI

struct ProgressBar: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showingGuide: Bool
    
    @State var progress = CGFloat(0)
    @Binding var index: Int
    @State var tag: Int
    var limit: Int
    
    var duration = 10.0
    
    @State var done = false
    
    // timer publishes a change every 0.1 seconds - this publisher is connected to a slot which evaluates the current position
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { g in
            ZStack (alignment: .leading) {
                // The progress bar is just two rects overlaid, of different widths
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray).frame(height: 3)
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .frame(width: done ? g.size.width : 0, height: 3)
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .frame(width: progress, height: 3)
                    // Bind timer to slot
                    .onReceive(timer) { input in
                        // If progress bar is full, move to next slide
                        if progress >= g.size.width {
                            done = true
                            progress = g.size.width - 1
                            if index < limit {
                                index += 1
                            }
                            else {
                                showingGuide = false
                            }
                        }
                        else if index == tag {
                            progress += 0.8
                            done = false
                        }
                        // If on last slide, end story
                        else {
                            progress = 0
                            if index > tag {
                                done = true
                            }
                        }
                }
            }
        }
    }
}
