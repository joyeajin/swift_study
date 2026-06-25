//
//  LoadingView.swift
//  study
//
//  Created by 예진 on 6/25/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20){
            ProgressView()
                .scaleEffect(1.3)
            
            Text("로그인 상태 확인 중 ~")
                .foregroundColor(.gray)
        }
        .padding()
        
    }
}
