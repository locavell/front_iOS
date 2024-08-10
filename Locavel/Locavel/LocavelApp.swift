//
//  LocavelApp.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//

import SwiftUI


@main
struct LocavelApp: App {
    var body: some Scene {
        WindowGroup {
            StartView()
                .accentColor(ColorManager.AccentColor)
        }
    }
}
