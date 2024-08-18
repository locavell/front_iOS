import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import Moya

struct kakaoButton: View {
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
                        // 소셜 로그인(회원가입 API CALL)
                        sendSocialLoginToken(token: oauthToken.accessToken)
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    if let oauthToken = oauthToken {
                        print("kakao success")
                        // 소셜 로그인(회원가입 API CALL)
                        sendSocialLoginToken(token: oauthToken.accessToken)
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
    
    // 서버에 소셜 로그인 토큰을 보내는 함수
    func sendSocialLoginToken(token: String) {
        provider.request(.sociallogin) { result in
            switch result {
            case .success(let response):
                do {
                    // 서버로부터의 응답 처리
                    let responseData = try response.mapJSON()
                    print("Server response: \(responseData)")
                } catch {
                    print("Failed to parse response: \(error)")
                }
            case .failure(let error):
                print("Failed to send token: \(error)")
            }
        }
    }
}

#Preview {
    kakaoButton()
}
