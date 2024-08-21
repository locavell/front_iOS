//
//  HomeView.swift
//  Locavel
//
//  Created by 박희민 on 8/8/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedTabInHome: Tab = .myRegion
    @Binding var selectedTab: Int  // Binding to the selected tab index in ContentView
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Tab View
            HStack {
                Button(action: {
                    selectedTabInHome = .myRegion
                }) {
                    Text("내 지역")
                        .foregroundColor(selectedTabInHome == .myRegion ? .red : .gray)
                        .font(.system(size: 16, weight: .bold))
                }
                .frame(width: 100)

                Button(action: {
                    selectedTabInHome = .interestRegion
                }) {
                    Text("관심 지역")
                        .foregroundColor(selectedTabInHome == .interestRegion ? .red : .gray)
                        .font(.system(size: 16, weight: .bold))
                }
                .frame(width: 100)
                
                Spacer()
                
                Button(action: {
                    selectedTab = 1  // Change to the index of SurroundView in TabView
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 22))
                        .foregroundColor(.black)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            
            if selectedTabInHome == .myRegion {
                // Original content for '내 지역'
                MyRegionView(viewModel: viewModel)
            } else {
                // New Interest Region View
                InterestRegionView()
            }
        }
        .onAppear {
            viewModel.fetchRegionName()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Enum to switch between tabs
enum Tab {
    case myRegion
    case interestRegion
}

//#Preview {
//    HomeView()
//}
