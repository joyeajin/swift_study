//
//  HomeView.swift
//  study
//
//  Created by 예진 on 6/19/26.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var message = ""

    var body: some View {
        let userEmail = Auth.auth().currentUser?.email ?? "이메일 없음"
        
        VStack(spacing: 20) {
            Text("홈 화면")
                .font(.largeTitle)

            Text("로그인 성공!")
                .foregroundColor(.green)
            
            Text("환영합니다, \(userEmail)")
                .font(.headline)
                .foregroundColor(.purple)

            Button {
                logout()
            } label: {
                Text("로그아웃")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
            }

            if !message.isEmpty {
                Text(message)
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .padding()
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            message = "로그아웃 실패: \(error.localizedDescription)"
        }
    }
}
