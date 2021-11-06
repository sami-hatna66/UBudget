//
//  VancancyView.swift
//  UBudget
//
//  Created by Sami Hatna on 22/08/2021.
//

import SwiftUI

struct VancancyView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var dateCollection: [DateStruct]
    var isOnboarding: Bool
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            ScrollView {
                ForEach(dateCollection.indices, id: \.self) { index in
                    if dateCollection[index].active {
                        DateWidget(dateArray: $dateCollection, index: index)
                    }
                }
            }.padding(10)
            .frame(width: UIScreen.main.bounds.width - 30, height: 300)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isOnboarding ? Color.gray : Color.black)
                    .opacity(isOnboarding ? 0.25 : 1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: (isOnboarding == false && colorScheme == .dark) ? 1 : 0)
                )
            )
            Button(action: {
                dateCollection.append(DateStruct(start: Date(), end: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!))
                print(dateCollection)
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .offset(x: 13, y: 13)
                    .overlay(Circle()
                                .stroke(Color.black, lineWidth: 1)
                                .offset(x: 13, y: 13)
                    )
            }
        }
    }
}
