//
//  PlaceDetailView.swift
//  Locavel
//
//  Created by 김의정 on 8/23/24.
//

import SwiftUI

struct PlaceDetailView: View {
    let placeId: Int
    @State private var placeDetail: PlaceDetail?
    @State private var isLoading = true
    @State private var errorMessage: String?
<<<<<<< HEAD
    @Environment(\.presentationMode) var presentationMode
=======
    @State private var showReviewView = false
>>>>>>> 50ae358ee7b34751eab9b9fec273012f1a041acd

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if isLoading {
                        ProgressView("Loading...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let placeDetail = placeDetail {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(placeDetail.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
<<<<<<< HEAD
                            Text(placeDetail.address)
                                .font(.subheadline)
=======
                            if let travelerRating = placeDetail.travelerRating {
                                Text("여행자 평점: \(travelerRating, specifier: "%.1f")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 10)
                            }
                        }
                        .padding(.bottom, 20)
                        
                        HStack(alignment: .center) {
                            // 리뷰 등록하기 버튼
                            Button(action: {
                                                // 리뷰 등록하기 버튼 클릭 시 ReviewView를 보여줌
                                                showReviewView.toggle()
                                            }) {
                                                Text("리뷰 등록하기")
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal)
                                                    .padding(.vertical, 10)
                                            }
                                            .background(Color("AccentColor"))
                                            .cornerRadius(25)
                                            .sheet(isPresented: $showReviewView) {
                                                // ReviewView를 호출하면서 placeId를 전달
                                                ReviewView(placeId: "\(placeId)")
                                            }
                            
                            // 공유하기 버튼
                            Button(action: {
                                // 공유하기 버튼 클릭 시 동작
                            }) {
                                Text("공유하기")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                            }
                            .background(Color.black)
                            .cornerRadius(25)
                            
                            // 길찾기 버튼
                            Button(action: {
                                // 길찾기 버튼 클릭 시 동작
                            }) {
                                Text("길찾기")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                            }
                            .background(Color.black)
                            .cornerRadius(25)
                            
                            // 북마크 아이콘 버튼
                            Button(action: {
                                // 북마크 버튼 클릭 시 동작
                            }) {
                                Image(systemName: "bookmark.circle.fill")
                                    .font(.system(size: 35, weight: .bold))
                                    .foregroundColor(.black)
                                    .background(Color.clear)
                            }
                        }
                        .padding(.bottom, 20)

                        Text("상세 사진")
                            .font(.headline)
                            .padding(.top, 5)
                        
                        if !placeDetail.reviewImgList.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 10) {
                                    ForEach(placeDetail.reviewImgList, id: \.self) { imageUrl in
                                        AsyncImage(url: URL(string: imageUrl)) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 150, height: 150)
                                                    .clipped()
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .frame(width: 150, height: 150)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(height: 150)
                        } else {
                            Text("리뷰 이미지가 없습니다")
>>>>>>> 50ae358ee7b34751eab9b9fec273012f1a041acd
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                            
                            HStack {
                                HStack(spacing: 2) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("AccentColor"))
                                    Text("\(placeDetail.generalRating, specifier: "%.1f")")
                                }
                                .font(.headline)
                                HStack(spacing: 2) {
                                    Image(systemName: "text.bubble")
                                        .foregroundColor(Color("AccentColor"))
                                    Text("1,710")
                                }
                                .font(.headline)
                                .padding(.leading, 15)
                                
                                if let travelerRating = placeDetail.travelerRating {
                                    Text("여행자 평점: \(travelerRating, specifier: "%.1f")")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .padding(.leading, 10)
                                }
                            }
                            .padding(.bottom, 20)
                            
                            HStack(alignment: .center) {
                                // 리뷰 등록하기 버튼
                                Button(action: {
                                    // 리뷰 등록하기 버튼 클릭 시 동작
                                }) {
                                    Text("리뷰 등록하기")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                }
                                .background(Color("AccentColor"))
                                .cornerRadius(25)
                                
                                // 공유하기 버튼
                                Button(action: {
                                    // 공유하기 버튼 클릭 시 동작
                                }) {
                                    Text("공유하기")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                }
                                .background(Color.black)
                                .cornerRadius(25)
                                
                                // 길찾기 버튼
                                Button(action: {
                                    // 길찾기 버튼 클릭 시 동작
                                }) {
                                    Text("길찾기")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                }
                                .background(Color.black)
                                .cornerRadius(25)
                                
                                // 북마크 아이콘 버튼
                                Button(action: {
                                    // 북마크 버튼 클릭 시 동작
                                }) {
                                    Image(systemName: "bookmark.circle.fill")
                                        .font(.system(size: 35, weight: .bold))
                                        .foregroundColor(.black)
                                        .background(Color.clear)
                                }
                            }
                            .padding(.bottom, 20)
                            
                            Text("상세 사진")
                                .font(.headline)
                                .padding(.top, 5)
                            
                            if !placeDetail.reviewImgList.isEmpty {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 10) {
                                        ForEach(placeDetail.reviewImgList, id: \.self) { imageUrl in
                                            AsyncImage(url: URL(string: imageUrl)) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 150, height: 150)
                                                        .clipped()
                                                case .failure:
                                                    Image(systemName: "photo")
                                                        .frame(width: 150, height: 150)
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(height: 150)
                            } else {
                                Text("리뷰 이미지가 없습니다")
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            AroundPlacesView()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("리뷰")
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 10)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Image("user")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("dsknjlvc")
                                                    .font(.system(size: 14, weight: .bold))
                                                Text("팔로워")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundColor(.gray)
                                                Text("772")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundColor(.gray)
                                            }
                                            HStack(spacing: 2) {
                                                ForEach(0..<5) { _ in
                                                    Image(systemName: "star.fill")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(Color("AccentColor"))
                                                }
                                                Text("여행객")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundColor(.gray)
                                                    .padding(.leading, 8)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.bottom, 10)
                                    
                                    HStack(spacing: 2) {
                                        Image("리뷰사진1")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                        Image("리뷰사진2")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                    }
                                    .padding(.bottom, 10)
                                    
                                    Text("동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세.")
                                        .font(.body)
                                }
                                Divider()
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("리뷰")
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 10)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Image("user")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("dsknjlvc")
                                                    .font(.system(size: 14, weight: .bold))
                                                Text("팔로워")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundColor(.gray)
                                                Text("772")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundColor(.gray)
                                            }
                                            HStack(spacing: 2) {
                                                ForEach(0..<5) { _ in
                                                    Image(systemName: "star.fill")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(Color("AccentColor"))
                                                }
                                                Text("여행객")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundColor(.gray)
                                                    .padding(.leading, 8)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.bottom, 10)
                                    
                                    HStack(spacing: 2) {
                                        Image("리뷰사진1")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                        Image("리뷰사진2")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                    }
                                    .padding(.bottom, 10)
                                    
                                    Text("동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세.")
                                        .font(.body)
                                }
                                Divider()
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                }
            }
            .background(Color.white)
            .onAppear {
                fetchPlaceDetail()
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
            })
        }
    }

    private func fetchPlaceDetail() {
        let urlString = "https://api.locavel.site/api/places/\(placeId)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(PlaceDetailResponse.self, from: data)
                    if apiResponse.isSuccess {
                        self.placeDetail = apiResponse.result
                    } else {
                        self.errorMessage = apiResponse.message
                    }
                } catch {
                    self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

struct PlaceDetail: Codable {
    let placeId: Int
    let name: String
    let address: String
    let longitude: Double
    let latitude: Double
    let generalRating: Double
    let travelerRating: Double?
    let reviewImgList: [String]
}

struct PlaceDetailResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PlaceDetail
}
