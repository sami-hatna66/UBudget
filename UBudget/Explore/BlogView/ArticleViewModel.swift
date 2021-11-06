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

class ArticleViewModel: ObservableObject {
    
    @Published var articles = [Article]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("Articles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
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
    
    func update(key: String, attribute: String, value: Int) {
        let ref = db.collection("Articles").document(key)
        ref.getDocument { (document, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                document?.reference.updateData([attribute: value])
            }
        }
    }
}
