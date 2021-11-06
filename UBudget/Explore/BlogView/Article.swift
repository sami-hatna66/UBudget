//
//  Article.swift
//  UBudget
//
//  Created by Sami Hatna on 11/09/2021.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import SDWebImageSwiftUI

// Object corresponding to an article stored in the FireStore online database
// When data is fetched from the backend, it is passed into an instance of this object
class Article {
    var dbRef: String
    var tag: Int
    var title: String
    var body: String
    var likes: Int
    var dislikes: Int
    
    var lightImageName: String
    var lightImage: WebImage
    
    var darkImageName: String
    var darkImage: WebImage
    
    init(dbRef: String, tag: Int, title: String, body: String, likes: Int, dislikes: Int, lightImageName: String, lightImage: WebImage, darkImageName: String, darkImage: WebImage) {
        self.dbRef = dbRef
        self.tag = tag
        self.title = title
        self.body = body
        self.likes = likes
        self.dislikes = dislikes
        self.lightImageName = lightImageName
        // Create WebImage instance from image url
        // Each article has a light mode and a dark mode image
        self.lightImage = WebImage(url: URL(string: lightImageName))
        self.darkImageName = lightImageName
        self.darkImage = WebImage(url: URL(string: darkImageName))
    }
}
