//
//  OpenArticle.swift
//  UBudget
//
//  Created by Sami Hatna on 16/09/2021.
//

import SwiftUI

struct OpenArticle: View {
    @Environment(\.colorScheme) var colorScheme
    
    var article: Article
    
    @Binding var isArticleOpened: Bool
    @Binding var snapOffset: CGFloat
    
    var body: some View {
        ScrollView {
            VStack{
                ZStack {
                    if colorScheme == .light {
                        article.lightImage
                            .resizable().scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 250)
                            .clipped().edgesIgnoringSafeArea(.top)
                    }
                    else {
                        article.darkImage
                            .resizable().scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 250).clipped()
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) { isArticleOpened.toggle() }
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable().frame(width: 20, height: 20)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                    }.offset(x: UIScreen.main.bounds.width / 2 - 15, y: -110)
                }
                
                VStack (alignment: .leading) {
                    Text(article.title).font(.title).bold().padding(.leading, 15).padding(.trailing, 15)
                    //When adding body in Firebase use "/n" for line break
                    Text(article.body.replacingOccurrences(of: "/n", with: "\n"))
                        .padding(.leading, 15).padding(.trailing, 15).padding(.top, 3)
                }
                
                LikeDislikeWidget(article: article).padding()

                Spacer()
            }
        }
    }
}

