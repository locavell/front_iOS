//
//  WishListView.swift
//  locavel_cookie
//
//  Created by 김경서 on 7/17/24.
//

import SwiftUI

struct ItemView: View {
    let item: Item
    
    var body: some View {
        VStack {
            Image("example")
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            Text(item.title)
                .font(.headline)
            Text(item.description)
                .font(.subheadline)
        }
        .frame(width: 180, height: 180)
    }
}

struct ItemScrollView: View {
    let data: [Item] = [
        Item(id: 1, title: "Item 1", description: "Description 1"),
        Item(id: 2, title: "Item 2", description: "Description 2"),
        Item(id: 3, title: "Item 3", description: "Description 3")
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(data) { item in
                    ItemView(item: item)
                }
            }
            .padding()
        }
    }
}

struct WishListView: View {
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    
                }
                // MARK : 내 지역
                HStack {
                    Text("내 지역")
                        .font(.title2)
                        .padding(.leading)
                    Spacer()
                    NavigationLink(destination: MyPlaceView()) {
                        Text("전체 보기")
                            .underline()
                    }
                    .padding(.trailing)
                }
                ItemScrollView()
                
                // MARK : 관심 지역
                HStack {
                    Text("관심 지역")
                        .font(.title2)
                        .padding(.leading)
                    Spacer()
                    NavigationLink(destination: InterestPlaceView()) {
                        Text("전체 보기")
                            .underline()
                    }
                    .padding(.trailing)
                }
                ItemScrollView()
                
                .navigationTitle("위시리스트")
            }
        }
    }
}

#Preview {
    WishListView()
}
