//
//  BottomSheetView.swift
//  Locavel
//
//  Created by 김의정 on 8/15/24.
//

import Foundation
import SwiftUI

struct BottomSheetView: View {
    @State private var isRegisterPlaceViewPresented = false
    @State private var isRegisterReviewViewPresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "plus.circle")
                    .foregroundColor(Color("AccentColor"))
                Text("새로운 장소를 등록할래요")
                    .font(.headline)
                    .padding(.leading, 20)
                    .onTapGesture {
                        isRegisterPlaceViewPresented = true
                    }
                Spacer()
            }
            .padding()
            
            HStack {
                Image(systemName: "hand.thumbsup")
                    .foregroundColor(Color("AccentColor"))
                Text("기존 장소 리뷰를 등록할래요")
                    .font(.headline)
                    .padding(.leading, 20)
                    .onTapGesture {
                        isRegisterReviewViewPresented = true
                    }
                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding()
        .fullScreenCover(isPresented: $isRegisterPlaceViewPresented) {
            RegisterPlaceView() // 새로운 장소 등록 화면
        }
        .fullScreenCover(isPresented: $isRegisterReviewViewPresented) {
            RegisterReviewView() // 새로운 장소 등록 화면
        }
    }
}
