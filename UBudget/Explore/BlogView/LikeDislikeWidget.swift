//
//  LikeDislikeWidget.swift
//  UBudget
//
//  Created by Sami Hatna on 16/09/2021.
//

import SwiftUI

// States:
// 1 - neither liked nor disliked
// 2 - liked
// 3 - disliked

struct LikeDislikeWidget: View {
    @Environment(\.colorScheme) var colorScheme
    
    var article: Article
    
    @State var state = 1
    
    let defaults = UserDefaults.standard
    
    @ObservedObject private var viewModel = ArticleViewModel()
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: state == 2 ? "hand.thumbsup.fill" : "hand.thumbsup")
            }.onTapGesture {
                switch state {
                case 1:
                    state = 2
                    viewModel.update(key: article.dbRef, attribute: "likes", value: article.likes + 1)
                    article.likes = article.likes + 1
                    var likedArticles: [String] = defaults.object(forKey: "likedArticles") as? [String] ?? []
                    if likedArticles.contains(article.dbRef) != true {
                        likedArticles.append(article.dbRef)
                    }
                    defaults.set(likedArticles, forKey: "likedArticles")
                case 3:
                    state = 2
                    viewModel.update(key: article.dbRef, attribute: "likes", value: article.likes + 1)
                    viewModel.update(key: article.dbRef, attribute: "dislikes", value: article.dislikes - 1)
                    article.likes += 1
                    article.dislikes -= 1
                    var likedArticles: [String] = defaults.object(forKey: "likedArticles") as? [String] ?? []
                    if likedArticles.contains(article.dbRef) != true {
                        likedArticles.append(article.dbRef)
                    }
                    defaults.set(likedArticles, forKey: "likedArticles")
                    var dislikedArticles: [String] = defaults.object(forKey: "dislikedArticles") as? [String] ?? []
                    if let index = dislikedArticles.firstIndex(of: article.dbRef) {
                        dislikedArticles.remove(at: index)
                    }
                    defaults.set(dislikedArticles, forKey: "dislikedArticles")
                default:
                    state = 1
                    viewModel.update(key: article.dbRef, attribute: "likes", value: article.likes - 1)
                    article.likes = article.likes - 1
                    var likedArticles: [String] = defaults.object(forKey: "likedArticles") as? [String] ?? []
                    if let index = likedArticles.firstIndex(of: article.dbRef) {
                        likedArticles.remove(at: index)
                    }
                    defaults.set(likedArticles, forKey: "likedArticles")
                }
            }
            Rectangle().frame(width: 1, height: 25)
            Group {
                Image(systemName: state == 3 ? "hand.thumbsdown.fill" : "hand.thumbsdown")
            }.onTapGesture {
                switch state {
                case 1:
                    state = 3
                    viewModel.fetchData()
                    viewModel.update(key: article.dbRef, attribute: "dislikes", value: article.dislikes + 1)
                    article.dislikes = article.dislikes + 1
                    var dislikedArticles: [String] = defaults.object(forKey: "dislikedArticles") as? [String] ?? []
                    if dislikedArticles.contains(article.dbRef) != true {
                        dislikedArticles.append(article.dbRef)
                    }
                    defaults.set(dislikedArticles, forKey: "dislikedArticles")
                case 2:
                    state = 3
                    viewModel.fetchData()
                    viewModel.update(key: article.dbRef, attribute: "dislikes", value: article.dislikes + 1)
                    viewModel.update(key: article.dbRef, attribute: "likes", value: article.likes - 1)
                    article.dislikes += 1
                    article.likes -= 1
                    var dislikedArticles: [String] = defaults.object(forKey: "dislikedArticles") as? [String] ?? []
                    if dislikedArticles.contains(article.dbRef) != true {
                        dislikedArticles.append(article.dbRef)
                    }
                    defaults.set(dislikedArticles, forKey: "dislikedArticles")
                    var likedArticles: [String] = defaults.object(forKey: "likedArticles") as? [String] ?? []
                    if let index = likedArticles.firstIndex(of: article.dbRef) {
                        likedArticles.remove(at: index)
                    }
                    defaults.set(likedArticles, forKey: "likedArticles")
                default:
                    state = 1
                    viewModel.fetchData()
                    viewModel.update(key: article.dbRef, attribute: "dislikes", value: article.dislikes - 1)
                    article.dislikes = article.dislikes - 1
                    var dislikedArticles: [String] = defaults.object(forKey: "dislikedArticles") as? [String] ?? []
                    if let index = dislikedArticles.firstIndex(of: article.dbRef) {
                        dislikedArticles.remove(at: index)
                    }
                    defaults.set(dislikedArticles, forKey: "dislikedArticles")
                }
            }.onAppear {
                // Check if user has already liked/disliked this particular article
                let defaults = UserDefaults.standard
                let likedArticles: [String] = defaults.object(forKey: "likedArticles") as? [String] ?? []
                let dislikedArticles: [String] = defaults.object(forKey: "dislikedArticles") as? [String] ?? []
                if likedArticles.contains(article.dbRef) {
                    state = 2
                }
                else if dislikedArticles.contains(article.dbRef) {
                    state = 3
                }
                else {
                    state = 1
                }
            }
        }
        .foregroundColor(colorScheme == .dark ? .black : .white)
        .padding(.leading, 10).padding(.trailing, 10)
        .padding(.top, 3).padding(.bottom, 3)
        .background(
            RoundedRectangle(cornerRadius: CGFloat(40)).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        )
    }
}



