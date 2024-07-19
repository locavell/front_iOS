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
        VStack(alignment: .leading, spacing: 2.5) {
            Image("example")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            Text(item.title)
                .font(.headline)
            Text("\(item.type)")
                .font(.subheadline)
            Text("\(item.hours)")
                .font(.subheadline)
            Text("\(item.rating)")
                .font(.subheadline)
        }
        .frame(width: 180, height: 230)
        .padding()
    }
}

struct ItemScrollView: View {
    let data: [Item] = [
        Item(id: 1, title: "Item 1", type: "식당", hours: "9:00 AM - 10:00 PM", rating: "4.5"),
        Item(id: 2, title: "Item 2", type: "카페", hours: "8:00 AM - 8:00 PM", rating: "4.0"),
        Item(id: 3, title: "Item 3", type: "서점", hours: "10:00 AM - 9:00 PM", rating: "4.8")
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
            VStack (spacing: 0){
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
