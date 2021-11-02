//
//  Toolbar.swift
//  UBudget
//
//  Created by Sami Hatna on 20/08/2021.
//

import SwiftUI

struct Toolbar: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showingSettings: Bool
    @Binding var showingExplore: Bool
    
    var body: some View {
        HStack (alignment: .center) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) { showingExplore.toggle() }
            }) {
                Image(systemName: "chart.pie.fill").resizable().frame(width: 20, height: 20).foregroundColor(colorScheme == .dark ? .white : .black)
            }
            
            Spacer()
            
            Image("ToolbarLogo").resizable().frame(width: 30, height: 30)
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) { showingSettings.toggle() }
            }) {
                Image(systemName: "gearshape.fill").resizable().frame(width: 20, height: 20).foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }.padding(.leading, 10).padding(.trailing, 10)
    }
}
