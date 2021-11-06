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
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { g in
            ZStack (alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray).frame(height: 3)
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .frame(width: done ? g.size.width : 0, height: 3)
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .frame(width: progress, height: 3)
                    .onReceive(timer) { input in
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
