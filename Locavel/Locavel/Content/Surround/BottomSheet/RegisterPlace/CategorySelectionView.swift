//
//  CategorySelectionView.swift
//  Locavel
//
//  Created by 김의정 on 8/16/24.
//

import Foundation
import SwiftUI

struct CategorySelectionView: View {
    @Binding var selectedCategory: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("카테고리 선택")
                .font(.headline)
            HStack {
                Button(action: {
                    selectedCategory = "food"
                }) {
                    Text("푸드")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .padding()
                        .background(selectedCategory == "food" ? Color("AccentColor") : Color.white)
                        .cornerRadius(50)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
                Button(action: {
                    selectedCategory = "activity"
                }) {
                    Text("액티비티")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .padding()
                        .background(selectedCategory == "activity" ? Color("AccentColor") : Color.white)
                        .cornerRadius(50)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
                Button(action: {
                    selectedCategory = "spot"
                }) {
                    Text("스팟")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .padding()
                        .background(selectedCategory == "spot" ? Color("AccentColor") : Color.white)
                        .cornerRadius(50)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
            }
        }
        .padding(.horizontal)
    }
}
