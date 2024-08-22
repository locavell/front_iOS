//
//  ContentView.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
                .tag(0)
            
            SurroundView()
                .tabItem {
                    Image(systemName: "location.north.circle")
                    Text("내 주변")
                }
                .tag(1)
            
            WishListView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("위시리스트")
                }
                .tag(2)
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("마이페이지")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
