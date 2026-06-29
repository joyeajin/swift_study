//
//  Memo.swift
//  study
//
//  Created by 예진 on 6/25/26.
//

import Foundation
import FirebaseFirestore

struct Memo: Identifiable{
    let id: String
    let text: String
    let createdAt: Timestamp
}
