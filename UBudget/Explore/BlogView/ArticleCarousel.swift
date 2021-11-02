//
//  ArticleCarousel.swift
//  UBudget
//
//  Created by Sami Hatna on 11/09/2021.
//

import SwiftUI

struct ArticleCarousel: View {
    @ObservedObject private var viewModel = ArticleViewModel()
    
    @Binding var snapOffset: CGFloat
    @Binding var swipeIndex: Int
    @Binding var openArticle: Article
    
    @Binding var isArticleOpened: Bool
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(Array(zip(viewModel.articles.indices, viewModel.articles)), id: \.0) { index, article in
                    ArticleWidget(article: article, index: index, swipeIndex: $swipeIndex).shadow(radius: index == swipeIndex ? 5:0)
                        .onTapGesture {
                            if index == swipeIndex {
                                openArticle = article
                                withAnimation(.easeInOut(duration: 0.3)) { isArticleOpened.toggle() }
                            }
                            else {
                                if index > swipeIndex {
                                    withAnimation(.linear(duration: 0.1)) {
                                        snapOffset -= 260
                                    }
                                    swipeIndex += 1
                                }
                                else {
                                    withAnimation(.linear(duration: 0.1)) {
                                        snapOffset += 260
                                    }
                                    swipeIndex -= 1
                                }
                            }
                        }
                }
            }.offset(x: snapOffset).onAppear {
                viewModel.fetchData()
            }
            .gesture(
                DragGesture()
                    .onEnded { gesture in
                        if gesture.translation.width < 0 {
                            if swipeIndex < viewModel.articles.count - 1 {
                                withAnimation(.linear(duration: 0.1)) {
                                    snapOffset -= 260
                                }
                                swipeIndex += 1
                            }
                        }
                        else if gesture.translation.width > 0 {
                            if swipeIndex > 0 {
                                withAnimation(.linear(duration: 0.1)) {
                                    snapOffset += 260
                                }
                                swipeIndex -= 1
                            }
                        }
                    }
                )
            }
    }
}

