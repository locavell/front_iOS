//
//  LocavelApp.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin


@main
struct LocavelApp: App {
    init() {
            KakaoSDK.initSDK(appKey:"9365f79d050ca0b60559280e2179d7fc")
        
            // 네이버 앱으로 로그인 허용
            NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
            // 브라우저 로그인 허용
            NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
            
            // 네이버 로그인 세로모드 고정
            NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
            
            // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
            NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = "naverlogin"
            NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = "PvltucNzxPNppwLpWS53"
            NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = "2GE8sL5_TZ"
            NaverThirdPartyLoginConnection.getSharedInstance().appName = "Locavel"
        }
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .accentColor(ColorManager.AccentColor)
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
