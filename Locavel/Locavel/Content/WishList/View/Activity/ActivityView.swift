//
//  ActivityView.swift
//  Locavel
//
//  Created by 박희민 on 7/21/24.
//

import SwiftUI


struct ActivityView: View {
    @StateObject private var viewModel = ActivityViewModel()

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("내 지역")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    NavigationLink(destination: ActivityMyRegionView(restaurants: viewModel.spotLocalRestaurants)) {
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
                        ForEach(viewModel.spotLocalRestaurants) { restaurant in
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
                                                    viewModel.toggleFavorite(for: restaurant)
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

                    NavigationLink(destination: ActivityInterestingView()) {
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
                        ForEach(viewModel.spotFavoriteRestaurants) { restaurant in
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
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
