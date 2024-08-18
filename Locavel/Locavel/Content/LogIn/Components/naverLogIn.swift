import Foundation
import NaverThirdPartyLogin

class NaverAuth: NSObject, UIApplicationDelegate, NaverThirdPartyLoginConnectionDelegate, ObservableObject {
    
    // 로그인 상태를 관리하는 속성
    @Published var isLoggedIn: Bool = false
    
    func handleNaverLogin() {
        print(#fileID, #function, #line, "- naver 앱 체크")
        if NaverThirdPartyLoginConnection
            .getSharedInstance()
            .isPossibleToOpenNaverApp() {
            NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
            NaverThirdPartyLoginConnection
                .getSharedInstance()
                .requestThirdPartyLogin()
        } else {
            NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
            NaverThirdPartyLoginConnection.getSharedInstance().requestThirdPartyLogin()
        }
    }

    //MARK: - 토큰 발급 성공
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        guard let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return }
        print(#fileID, #function, #line, "- naver token : \(String(describing: loginInstance.accessToken))")
        
        // 로그인 성공 시, isLoggedIn을 true로 설정
        self.isLoggedIn = true
        
        // 여기에서 서버에 accessToken을 날려줄 예정이므로 naver token의 accessToken을 가지고와야 한다.
    }
    
    //MARK: - 토큰 갱신시
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print(#fileID, #function, #line, "- 토큰 갱신 완료")
        
        // 갱신된 토큰이 유효하다면, 여전히 로그인 상태로 간주
        self.isLoggedIn = true
    }
    
    //MARK: - 로그아웃(토큰 삭제)시
    func oauth20ConnectionDidFinishDeleteToken() {
        print(#fileID, #function, #line, "- 네이버 토큰이 삭제되었습니다")
        
        // 로그아웃 시, isLoggedIn을 false로 설정
        self.isLoggedIn = false
    }
    
    //MARK: - Error발생시
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print(#fileID, #function, #line, "- naver login error: \(error.localizedDescription)")
        
        // 에러 발생 시 로그인 상태를 false로 설정
        self.isLoggedIn = false
    }
}
