//
//  ExploreView.swift
//  UBudget
//
//  Created by Sami Hatna on 22/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreView: View {
    @State var isArticleOpened = false
    @State var swipeIndex = 0
    // Empty instance of Article - only needed for initialisation
    // When article is opened, the attributes for this object will be changed to those of that article
    @State var openArticle = Article(dbRef: "", tag: 1, title: "", body: "", likes: 0, dislikes: 0, lightImageName: "", lightImage: WebImage(url: URL(string: "")), darkImageName: "", darkImage: WebImage(url: URL(string: "")))
    // For carousel
    @State var snapOffset = (UIScreen.main.bounds.width / 2) - 125
    @State var first = true
    
    @State var graphData: [SaveData]
    @Binding var showingExplore: Bool
    
    var body: some View {
        // View will either display explore tab or current article
        if isArticleOpened {
            OpenArticle(article: openArticle, isArticleOpened: $isArticleOpened, snapOffset: $snapOffset)
        }
        
        else {
            ScrollView (showsIndicators: false) {
                CrossButton(showingExplore: $showingExplore)
                
                Text("Explore").font(Font.custom("DIN", size: 40)).padding(.bottom, 15)
                
                if graphData.count > 1 {
                    SpendGraph(isEndScreen: false, graphData: $graphData)
                }

                let twoColumnGrid = [GridItem(.flexible(), spacing: 7), GridItem(.flexible(), spacing: 7)]
                if graphData.count >= 1 {
                    LazyVGrid(columns: twoColumnGrid, spacing: 0) {
                        AverageView(inputData: $graphData)
                        RemaningView(inputData: $graphData)
                    }.padding([.leading, .trailing], 5).padding(.bottom, 15)
                }
                
                Text("Blog").font(Font.custom("DIN", size: 30))
                
                ArticleCarousel(snapOffset: $snapOffset, swipeIndex: $swipeIndex, openArticle: $openArticle, isArticleOpened: $isArticleOpened).padding(.bottom, 250)
            }
        }
    }
}
