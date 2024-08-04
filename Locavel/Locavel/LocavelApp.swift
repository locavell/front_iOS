//
//  LocavelApp.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//

import SwiftUI
import NaverThirdPartyLogin

@main
struct LocavelApp: App {
    
    init() {
            //naver
            // 네이버 앱으로 로그인 허용
            NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
            // 브라우저 로그인 허용
            NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
            
            // 네이버 로그인 세로모드 고정
            NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
            
            // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
            NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = kServiceAppUrlScheme
            NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = kConsumerKey
            NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = kConsumerSecret
            NaverThirdPartyLoginConnection.getSharedInstance().appName = kServiceAppName
        }
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .accentColor(ColorManager.AccentColor)
        }
    }
}
