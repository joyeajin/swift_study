//
//  SignUpView.swift
//  study
//
//  Created by 예진 on 6/18/26.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var message = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("회원가입")
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

            SecureField("비밀번호 확인", text: $confirmPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            Button {
                signUp()
            } label: {
                Text("회원가입 완료")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            }

            if !message.isEmpty {
                Text(message)
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("회원가입")
    }

    private func signUp() {
        if password != confirmPassword {
            message = "비밀번호가 일치하지 않습니다."
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                message = "회원가입 실패: \(error.localizedDescription)"
            } else {
                message = "회원가입 성공!"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    dismiss()
                }
            }
        }
    }
}
