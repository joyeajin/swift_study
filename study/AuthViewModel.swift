//
//  AuthViewModel.swift
//  study
//
//  Created by 예진 on 6/25/26.
//

import Foundation
import Combine
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUserEmail: String = ""
    @Published var isLoading: Bool = true

    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        listenAuthState()
    }

    func listenAuthState() {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.isLoggedIn = true
                self.currentUserEmail = user.email ?? "이메일 없음"
            } else {
                self.isLoggedIn = false
                self.currentUserEmail = ""
            }
            
            self.isLoading = false
        }
    }

    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
