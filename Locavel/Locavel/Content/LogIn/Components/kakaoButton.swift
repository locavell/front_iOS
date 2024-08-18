//
//  kakaoButton.swift
//  Locavel
//
//  Created by 김경서 on 8/17/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct kakaoButton: View {
    var body: some View {
        Button {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                           UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                               if let error = error {
                                   print(error)
                               }
                               if let oauthToken = oauthToken{
                                   // 소셜 로그인(회원가입 API CALL)
                               }
                           }
                       } else {
                           UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                               if let error = error {
                                   print(error)
                               }
                               if let oauthToken = oauthToken{
                                   print("kakao success")
                                   // 소셜 로그인(회원가입 API CALL)
                               }
                           }
                       }
        } label:{
            HStack(spacing: 10) {
                Image("kakao")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("카카오로 시작하기")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(width: 281, height: 51)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.yellow))
        }
        .frame(width: 281, height: 51)
    }
}
    
#Preview {
    kakaoButton()
}
