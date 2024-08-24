//
//  AddRegionView.swift
//  Locavel
//
//  Created by 김의정 on 8/21/24.
//

import Foundation
import SwiftUI

// View for adding a new region
struct AddRegionView: View {
    @State private var selectedRegions: Set<String> = []
    @Environment(\.presentationMode) var presentationMode
    
    let regions = ["제주도", "강원도", "경기도", "서울"]
    var onAddRegions: (([String]) -> Void)? // Closure to pass selected regions back
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarInInterestRegion()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(regions, id: \.self) { region in
                            VStack {
                                ZStack {
                                    Image(region)
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 70, height: 70)
                                        .overlay(
                                            Circle().stroke(selectedRegions.contains(region) ? Color("AccentColor") : Color.clear, lineWidth: 3)
                                        )
                                }
                                
                                Text(region)
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            .onTapGesture {
                                if selectedRegions.contains(region) {
                                    selectedRegions.remove(region)
                                } else {
                                    selectedRegions.insert(region)
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                if !selectedRegions.isEmpty {
                    Button(action: {
                        onAddRegions?(Array(selectedRegions))
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("관심 지역 \(selectedRegions.count)개 추가")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 18)
                            .padding(.horizontal, 70)
                            .background(Color("AccentColor"))
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("관심 지역 추가")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            })
        }
    }
}

// Search bar component
struct SearchBarInInterestRegion: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            TextField("검색", text: $searchText)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        }
        .padding(.horizontal)
    }
}
