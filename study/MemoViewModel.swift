//
//  MemoViewModel.swift
//  study
//
//  Created by 예진 on 6/25/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class MemoViewModel: ObservableObject {
    @Published var memos: [Memo] = []
    
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func saveMemo(text: String, completion: @escaping (Error?) -> Void){
        guard let user = Auth.auth().currentUser else {
            completion(NSError(domain:"", code:401, userInfo: [NSLocalizedDescriptionKey:"로그인된 사용자가 없습니다."]))
            return
        }
        
        let data: [String:Any] = [
            "text":text,
            "createdAt":Timestamp()
        ]
        
        db.collection("users")
            .document(user.uid)
            .collection("memos")
            .addDocument(data: data){error in
                completion(error)
            }
    }
    
    func listenMemos() {
           guard let user = Auth.auth().currentUser else { return }

           listener?.remove()

           listener = db.collection("users")
               .document(user.uid)
               .collection("memos")
               .order(by: "createdAt", descending: true)
               .addSnapshotListener { snapshot, error in
                   if let documents = snapshot?.documents {
                       DispatchQueue.main.async {
                           self.memos = documents.map { doc in
                               Memo(
                                   id: doc.documentID,
                                   text: doc["text"] as? String ?? "",
                                   createdAt: doc["createdAt"] as? Timestamp ?? Timestamp()
                               )
                           }
                       }
                   }
               }
       }

       deinit {
           listener?.remove()
       }
}
