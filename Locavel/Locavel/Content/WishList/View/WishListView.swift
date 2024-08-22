//
//  WishListView.swift
//  testbaki
//
//  Created by 박희민 on 7/18/24.
//

import SwiftUI

enum tapInfo: String, CaseIterable {
    case food = "푸드"
    case spot = "스팟"
    case activity = "액티비티"
}

struct WishListView: View {
    
    @Binding var selectedTab: Int
    @State private var selectedPicker: tapInfo = .food
    @Namespace private var animation
    
    var body: some View {
        NavigationView {
            VStack {
                animate()
                InfoView(selectedTab: $selectedTab, tests: selectedPicker)
            }
            .navigationBarTitle(Text("위시리스트"), displayMode: .large)
        }
    }
    
    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(tapInfo.allCases, id: \.self) { item in
                VStack {
                    Text(item.rawValue)
                        .font(.title3)
                        .frame(maxWidth: .infinity/3, minHeight: 50)
                        .foregroundColor(selectedPicker == item ? ColorManager.AccentColor : .gray)

                    if selectedPicker == item {
                        Capsule()
                            .accentColor(ColorManager.AccentColor)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "info", in: animation)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedPicker = item
                    }
                }
            }
        }
    }
}

//struct WishListView_Previews: PreviewProvider {
//    static var previews: some View {
//        WishListView()
//    }
//}
