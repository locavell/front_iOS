//
//  ContentView.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
            SurroundView()
                .tabItem {
                    Image(systemName: "location.north.circle")
                    Text("홈")
                }
            WishListView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("위시리스트")
                }
            MyPageView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("마이페이지")
                }
        }
    }
}

#Preview {
    ContentView()
}
