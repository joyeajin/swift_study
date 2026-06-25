//
//  LoginView.swift
//  study
//
//  Created by 예진 on 6/19/26.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var message: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("로그인")
                    .font(.title)

                TextField("이메일", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                SecureField("비밀번호", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                Button {
                    login()
                } label: {
                    Text("로그인 시도")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                NavigationLink {
                    SignUpView()
                } label: {
                    Text("회원가입 하러가기")
                        .foregroundColor(.blue)
                }

                if !message.isEmpty {
                    Text(message)
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("로그인")
        }
    }

    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                message = "로그인 실패: \(error.localizedDescription)"
            } else {
                message = "로그인 성공!"
            }
        }
    }
}
