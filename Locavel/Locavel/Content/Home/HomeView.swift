//
//  HomeView.swift
//  Locavel
//
//  Created by 박희민 on 8/8/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top Tab View
                HStack {
                    Button(action: {}) {
                        Text("내 지역")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .frame(width: 100)

                    Button(action: {}) {
                        Text("관심 지역")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .frame(width: 100)
                    
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 22))
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        // 추천 플레이스 Section
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("오늘의 추천 플레이스")
                                    .font(.system(size: 18, weight: .bold))
                                Spacer()
                                Button(action: {}) {
                                    Image(systemName: "arrow.clockwise")
                                }
                            }
                            .padding(.bottom, 10)
                            
                            HStack {
                                Image("songdo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .clipped()
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("송도달빛축제공원")
                                        .font(.system(size: 16, weight: .bold))
                                    Text("인천광역시에서 락페스티벌을 즐길 수 있는 공간이에요!")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(Color("AccentColor"))
                                            .font(.system(size: 14))
                                        Text("4.3")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                        Image(systemName: "bubble.right")
                                            .foregroundColor(Color("AccentColor"))
                                            .font(.system(size: 14))
                                        Text("1,110")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.leading, 7)
                            }
                        }
                        .padding()

                        // 인기 플레이스 Section
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("\(viewModel.regionName) 인기 플레이스")
                                    .font(.system(size: 18, weight: .bold))
                                Spacer()
                                Button(action: viewModel.fetchRegionName) {
                                    Image(systemName: "arrow.clockwise")
                                }
                            }
                            VStack {
                                Image("muddyday")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .clipped()
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("머디데이")
                                        .font(.system(size: 16, weight: .bold))
                                    Text("편안함과 행복을 동시에 느낄 수 있는 아기자기한 공간")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("현지인")
                                                .font(.system(size: 14, weight: .bold))
                                            HStack {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.red)
                                                    .font(.system(size: 14))
                                                Text("4.61 (217)")
                                                    .font(.system(size: 14))
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        VStack(alignment: .leading) {
                                            Text("여행객")
                                                .font(.system(size: 14, weight: .bold))
                                            HStack {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.red)
                                                    .font(.system(size: 14))
                                                Text("4.61 (217)")
                                                    .font(.system(size: 14))
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding(.top, 5)
                                .padding([.leading, .trailing, .bottom], 10) // Add padding around the inner VStack
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Light gray border
                            )
                        }
                        .padding(.horizontal)

                        // User Activity Section
                        VStack(alignment: .leading, spacing: 5) {
                            Text("내 지역에서 활동 중인 다른 유저도 확인해보세요")
                                .font(.system(size: 17, weight: .bold))
                            
                            VStack(spacing: 10) {
                                ForEach(0..<2) { _ in
                                    HStack {
                                        Image("user")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                        VStack(alignment: .leading) {
                                            Text("dsknjlvc")
                                                .font(.system(size: 14, weight: .bold))
                                            Text("팔로워 772 | 팔로잉 772 | 리뷰 수 113")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                viewModel.fetchRegionName()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    HomeView()
}
