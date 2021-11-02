//
//  ArticleWidget.swift
//  UBudget
//
//  Created by Sami Hatna on 11/09/2021.
//

import SwiftUI

struct ArticleWidget: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var article: Article
    var index: Int
    @Binding var swipeIndex: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if colorScheme == .light {
                    article.lightImage.resizable()
                        .scaledToFill().frame(width: 250, height: 150).clipped()
                }
                else {
                    article.darkImage.resizable()
                        .scaledToFill().frame(width: 250, height: 150).clipped()
                }
                Text(article.title).frame(width: 240, alignment: .leading)
                    .font(.system(size: 15, weight: .medium)).lineLimit(1).padding(.leading, 5).padding(.trailing, 5).padding(.bottom, -7)
                Text(article.body)
                    .font(.system(size: 12)).foregroundColor(colorScheme == .light ? .secondary : Color(red: 153/255, green: 153/255, blue: 160/255) ).frame(width: 240, height: 30, alignment: .leading).padding(.bottom, 10).padding(.leading, 5).padding(.trailing, 5)
            }
        }.background(colorScheme == .light ? Color(red: 246/255, green: 246/255, blue: 246/255) : Color(red: 27/255, green: 28/255, blue: 30/255)).clipShape(RoundedRectangle(cornerRadius: CGFloat(15))).scaleEffect(index == swipeIndex ? 1 : 0.9).animation(.easeInOut(duration: 0.3), value: index == swipeIndex ? 1 : 0.9)
    }
}

