import Foundation
import NaverThirdPartyLogin

class NaverAuth: NSObject, UIApplicationDelegate, NaverThirdPartyLoginConnectionDelegate, ObservableObject {
    func handleNaverLogin() {
        //네이버 앱이 깔려있는 경우
        print(#fileID, #function, #line, "- naver 앱 체크")
        if NaverThirdPartyLoginConnection
            .getSharedInstance()
            .isPossibleToOpenNaverApp() {
            NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
            
            NaverThirdPartyLoginConnection
                .getSharedInstance()
                .requestThirdPartyLogin()
        } else { //네이버 앱이 깔려있지 않은 경우
            NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
            NaverThirdPartyLoginConnection.getSharedInstance().requestThirdPartyLogin()
        }
    }

    //MARK: - 토큰 발급 성공
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        guard let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return }
        print(#fileID, #function, #line, "- naver token : \(String(describing: loginInstance.accessToken))")
        // 여기에서 서버에 accessToken을 날려줄 예정이므로 naver token의 accessToken을 가지고와야 한다.
    }
    
    //MARK: - 토큰 갱신시
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print(#fileID, #function, #line, "- 토큰 갱신 완료")
    }
    
    //MARK: - 로그아웃(토큰 삭제)시
    func oauth20ConnectionDidFinishDeleteToken() {
        print(#fileID, #function, #line, "- 네이버 토큰이 삭제되었습니다")
    }
    
    //MARK: - Error발생시
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print(#fileID, #function, #line, "- naver login error: \(error.localizedDescription)")
    }
    
}
