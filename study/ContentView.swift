//
//  ContentView.swift
//  study
//
//  Created by 예진 on 5/19/26.
//

import SwiftUI

struct ContentView: View {
    @State private var authViewModel = AuthViewModel()

    var body: some View {
        
        if authViewModel.isLoading{
            LoadingView()
        }else if authViewModel.isLoggedIn {
            HomeView(authViewModel: authViewModel)
        } else {
            LoginView(authViewModel: authViewModel)
        }
    }
}
