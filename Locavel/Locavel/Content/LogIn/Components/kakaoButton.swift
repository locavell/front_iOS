import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import Moya

struct kakaoButton: View {
    @Binding var isLoggedIn: Bool // 로그인 상태를 바인딩으로 받음

    // Moya Provider 설정
    let provider = MoyaProvider<LoginAPI>()
    
    var body: some View {
        Button {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    if let oauthToken = oauthToken {
                        sendSocialLoginToken(token: oauthToken.accessToken)
                        isLoggedIn = true // 로그인 성공 시 상태를 true로 설정
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    if let oauthToken = oauthToken {
                        sendSocialLoginToken(token: oauthToken.accessToken)
                        isLoggedIn = true // 로그인 성공 시 상태를 true로 설정
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
    
    func sendSocialLoginToken(token: String) {
        // 서버로 토큰 전송 로직
    }
}
