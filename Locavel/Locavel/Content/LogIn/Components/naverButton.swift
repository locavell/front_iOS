//
//  naverButton.swift
//  Locavel
//
//  Created by 김경서 on 8/17/24.
//

import SwiftUI
import NaverThirdPartyLogin

struct naverButton: View {
    @StateObject var naverAuth = NaverAuth()

    var body: some View {
        Button(action: {
            naverAuth.handleNaverLogin()
        }) {
            HStack(spacing: 10) {
                Image("naver")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("네이버로 시작하기")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(width: 281, height: 51)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
        }
        .frame(width: 281, height: 51)
        .navigationDestination(isPresented: $naverAuth.isLoggedIn) {
            SignUpView()
        }
    }
}

