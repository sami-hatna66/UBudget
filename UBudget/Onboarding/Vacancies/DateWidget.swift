//
//  DateWidget.swift
//  UBudget
//
//  Created by Sami Hatna on 30/07/2021.
//

import SwiftUI

struct DateWidget: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var dateArray: [DateStruct]
    @State var index: Int
    
    var body: some View {
//        HStack (spacing: 0) {
//            Text("From").foregroundColor(.white).font(Font.custom("DIN", size: 15)).lineLimit(1).minimumScaleFactor(0.5)
//            DatePicker("", selection: $dateArray[index].start, displayedComponents: [.date])
//                .labelsHidden()
//                .accentColor(Color.black)
//                .background(RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black : Color.white))
//                .scaleEffect(0.8)
//
//            Text("to").foregroundColor(.white).font(Font.custom("DIN", size: 15)).minimumScaleFactor(0.5)
//            DatePicker("", selection: $dateArray[index].end, displayedComponents: [.date])
//                .labelsHidden()
//                .accentColor(Color.black)
//                .background(RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black : Color.white))
//                .scaleEffect(0.8)
//
//            Button(action: {
//                dateArray[index].active = false
//            }) {
//                Image(systemName: "trash.fill").foregroundColor(.white)
//            }
//        }.frame(maxWidth: .infinity).padding(.leading, 10).padding(.trailing, 10)
        let columnGrid = [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)]
        LazyVGrid(columns: columnGrid, spacing: 0) {
            Text("From  ").foregroundColor(.white).font(Font.custom("DIN", size: 15)).lineLimit(1).minimumScaleFactor(0.5)
            
            DatePicker("", selection: $dateArray[index].start, displayedComponents: [.date])
                .labelsHidden()
                .accentColor(Color.black)
                .background(RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black : Color.white))
                .scaleEffect(0.8)
            
            Text("to").foregroundColor(.white).font(Font.custom("DIN", size: 15)).minimumScaleFactor(0.5)
            
            DatePicker("", selection: $dateArray[index].end, displayedComponents: [.date])
                .labelsHidden()
                .accentColor(Color.black)
                .background(RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black : Color.white))
                .scaleEffect(0.8)
    
            Button(action: {
                dateArray[index].active = false
            }) {
                Image(systemName: "trash.fill").foregroundColor(.white)
            }
        }.frame(width: UIScreen.main.bounds.width - 30)
    }
}
