//
//  ArticleViewModel.swift
//  UBudget
//
//  Created by Sami Hatna on 11/09/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase
import SDWebImageSwiftUI

// Object responsible for reading and writing data back to firestore
class ArticleViewModel: ObservableObject {
    
    // Carousel uses this published list to populate itself
    @Published var articles = [Article]()
    
    // Initialise firestore connection
    private var db = Firestore.firestore()
    
    func fetchData() {
        // Listen for changes to db
        db.collection("Articles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Create Article instances from fetched data
            self.articles = documents.map { (queryDocumentSnapshot) -> Article in
                let data = queryDocumentSnapshot.data()

                let id = data["id"] as? Int ?? 0
                let title = data["title"] as? String ?? ""
                let body = data["body"] as? String ?? ""
                let lightImage = data["lightImage"] as? String ?? ""
                let dislikes = data["dislikes"] as? Int ?? 0
                let likes = data["likes"] as? Int ?? 0
                let darkImage = data["darkImage"] as? String ?? ""

                return Article(dbRef: queryDocumentSnapshot.documentID, tag: id, title: title, body: body, likes: likes, dislikes: dislikes, lightImageName: lightImage, lightImage: WebImage(url: URL(string: "")), darkImageName: darkImage, darkImage: WebImage(url: URL(string: "")))
            }
        }
    }
    
    // Function for updating data in the backend
    // Used for updating an article's likes and dislikes
    func update(key: String, attribute: String, value: Int) {
        // key is the document id in FireStore - how we access specific documents
        let ref = db.collection("Articles").document(key)
        ref.getDocument { (document, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                // Change passed in attribute to passed in data
                document?.reference.updateData([attribute: value])
            }
        }
    }
}
