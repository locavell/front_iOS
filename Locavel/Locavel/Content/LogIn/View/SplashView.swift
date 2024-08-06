//
//  Splash.swift
//  Locavel
//
//  Created by 김경서 on 7/31/24.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.3)
                .ignoresSafeArea()
            Image("Logo")
                .resizable()
                .frame(width: 183, height: 37)
        }
    }
}

#Preview {
    SplashView()
}
