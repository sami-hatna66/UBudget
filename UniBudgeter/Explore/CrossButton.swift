//
//  CrossButton.swift
//  UniBudgeter
//
//  Created by Sami Hatna on 11/09/2021.
//

import SwiftUI

struct CrossButton: View {
    @Binding var showingExplore: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) { showingExplore.toggle() }
            }) {
                Image(systemName: "xmark.circle").resizable().frame(width: 20, height: 20).foregroundColor(colorScheme == .dark ? .white : .black)
            }.padding(.trailing, 10)
        }
    }
}

