//
//  LoadingPageView.swift
//  Locavel
//
//  Created by 김의정 on 8/19/24.
//

import Foundation
import SwiftUI

struct LoadingPageView: View {
    @State private var isActive = false
    @State private var opacity = 1.0

    var body: some View {
        VStack {
            Spacer()
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150) // Adjust size as needed
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 3)) {
                        opacity = 0.0
                    }
                }
            Spacer()
        }
        .background(Color.white) // Optional: Set background color
        .edgesIgnoringSafeArea(.all) // Optional: Extend background to edges
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
        }
    }
}
