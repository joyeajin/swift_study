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
    @StateObject private var memoViewModel = MemoViewModel()
    
    @State private var memoText = ""
    @State private var message = ""
    
    var body: some View {
        let userEmail = Auth.auth().currentUser?.email ?? "이메일 없음"
        let isVerified = Auth.auth().currentUser?.isEmailVerified ?? false
        
        VStack(spacing: 20) {
            Text("홈 화면")
                .font(.largeTitle)
            
            Text("환영합니다, \(userEmail)")
                .font(.headline)
                .foregroundColor(.purple)
            
            Text(isVerified ? "이메일 인증 완료":"이메일 미인증")
                .foregroundColor(isVerified ? .green : .orange)
            
            Button{
                refreshVerificationStatus()
            } label:{
                Text("인증 상태 새로고침")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            Button {
                sendVerificationEmail()
            } label: {
                Text("인증 메일 다시 보내기")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            
            TextField("메모 입력", text: $memoText)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            Button {
                saveMemo()
            } label: {
                Text("메모 저장")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            }
            
            List(memoViewModel.memos) { memo in
                Text(memo.text)
            }
            .onAppear {
                memoViewModel.listenMemos()
            }
            
            
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
    
    private func saveMemo() {
        print("저장 버튼 눌림")
        
        guard !memoText.isEmpty else {
            message = "메모를 입력하세요."
            return
        }
        
        memoViewModel.saveMemo(text: memoText) { error in
            if let error = error {
                message = "저장 실패: \(error.localizedDescription)"
                print("저장 실패:", error.localizedDescription)
                
            } else {
                message = "저장 성공!"
                print("저장 성공")
                
                memoText = ""
                
            }
        }
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            message = "로그아웃 실패: \(error.localizedDescription)"
        }
    }
    
    private func refreshVerificationStatus(){
        Auth.auth().currentUser?.reload {error in
            if let error = error{
                message = "새로고침 실패: \(error.localizedDescription)"
            }else{
                message = "인증 상태 재확인 완료."
            }
        }
    }
    
    private func sendVerificationEmail() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                message = "메일 전송 실패: \(error.localizedDescription)"
            } else {
                message = "인증 메일을 다시 보냈어요."
            }
        }
    }
}
