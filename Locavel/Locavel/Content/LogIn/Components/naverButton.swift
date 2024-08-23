//
//  naverButton.swift
//  Locavel
//
//  Created by 김경서 on 8/17/24.
//

import SwiftUI
import NaverThirdPartyLogin

struct naverButton: View {
    @Binding var isLoggedIn: Bool // 로그인 상태를 바인딩으로 받음
    @ObservedObject var naverAuth = NaverAuth() // 네이버 로그인 객체

    var body: some View {
        Button {
            naverAuth.handleNaverLogin()
        } label:{
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
    }
}


