//
//  SpotView.swift
//  Locavel
//
//  Created by 박희민 on 7/21/24.

import SwiftUI

struct SpotView: View {
    @StateObject private var viewModel = SpotViewModel()

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("내 지역")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    NavigationLink(destination: SpotMyRegionView(restaurants: viewModel.SpotlocalRestaurants)) {
                        Text("전체보기")
                            .font(.footnote)
                            .underline()
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                            .padding(.leading)
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.SpotlocalRestaurants) { restaurant in
                            VStack {
                                Image(restaurant.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipped()
                                    .overlay(
                                        HStack {
                                            Spacer()
                                            VStack {
                                                Button(action: {
                                                    if restaurant.isFavorite {
                                                        viewModel.removeWishlist(placeId: String(restaurant.id)) { success in
                                                            if success {
                                                                print("위시리스트에서 제거되었습니다.")
                                                            } else {
                                                                print("제거 실패.")
                                                            }
                                                        }
                                                    } else {
                                                        viewModel.addWishlist(placeId: String(restaurant.id)) { success in
                                                            if success {
                                                                print("위시리스트에 추가되었습니다.")
                                                            } else {
                                                                print("추가 실패.")
                                                            }
                                                        }
                                                    }
                                                }) {
                                                    Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                                                        .foregroundColor(.red)
                                                        .padding()
                                                }
                                                Spacer()
                                            }
                                        }
                                    )

                                Text(restaurant.name)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 5)

                                Text(restaurant.hours)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                HStack(spacing: 2) {
                                    ForEach(0..<5) { index in
                                        Image(systemName: index < Int(restaurant.rating) ? "star.fill" : "star")
                                            .foregroundColor(index < Int(restaurant.rating) ? .yellow : .gray)
                                    }

                                    Text(String(format: "%.1f", restaurant.rating))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(width: 180)
                            .padding()
                        }
                    }
                }

                Spacer()

                HStack {
                    Text("관심 지역")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    NavigationLink(destination: SpotInterestingView()) {
                        Text("전체보기")
                            .font(.footnote)
                            .underline()
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                            .padding(.leading)
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.favoriteRestaurants) { restaurant in
                            VStack {
                                Image(restaurant.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipped()

                                Text(restaurant.name)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 5)

                                Text(restaurant.hours)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                HStack(spacing: 2) {
                                    ForEach(0..<5) { index in
                                        Image(systemName: index < Int(restaurant.rating) ? "star.fill" : "star")
                                            .foregroundColor(index < Int(restaurant.rating) ? .yellow : .gray)
                                    }

                                    Text(String(format: "%.1f", restaurant.rating))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(width: 180)
                            .padding()
                        }
                    }
                }
            }
        }.onAppear {
            // 임시로 좌표 설정 (실제 앱에서는 사용자의 현재 위치를 사용해야 합니다.)
            viewModel.getRecommendedRestaurants(latitude: 37.5665, longitude: 126.9780) // 예: 서울의 위도와 경도
        }
    }
}

struct SpotView_Previews: PreviewProvider {
    static var previews: some View {
        SpotView()
    }
}
