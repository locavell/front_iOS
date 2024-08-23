import SwiftUI

struct MyRegionView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isUserViewActive = false
    @State private var places: [PlaceListItem] = []
    @State private var errorMessage: String?
    @State private var selectedPlace: PlaceListItem?
    @State private var selectedImageURL: String?
    @State private var isPlaceDetailViewPresented = false

    var body: some View {
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
                        Button(action: {
                            viewModel.fetchRegionName()
                            fetchPlaces()
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                    if let selectedPlace = selectedPlace {
                        VStack {
                            if let imageURL = selectedImageURL {
                                AsyncImage(url: URL(string: imageURL)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: .infinity)
                                            .cornerRadius(10)
                                            .clipped()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 200)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                    .cornerRadius(10)
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text(selectedPlace.name)
                                    .font(.system(size: 16, weight: .bold))
                                Text(selectedPlace.address)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("현지인")
                                            .font(.system(size: 14, weight: .bold))
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(Color("AccentColor"))
                                                .font(.system(size: 14))
                                            Text("\(selectedPlace.rating, specifier: "%.2f") (\(selectedPlace.reviewCount))")
                                                .font(.system(size: 14))
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .padding(.top, 5)
                            .padding([.leading, .trailing, .bottom], 10)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .onTapGesture {
                            isPlaceDetailViewPresented = true
                        }
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
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
                                    .onTapGesture { // 2. 이미지를 클릭했을 때 액션을 추가
                                        isUserViewActive = true
                                    }
                                
                                VStack(alignment: .leading) {
                                    Text("dsknjlvc")
                                        .font(.system(size: 14, weight: .bold))
                                    Text("팔로워 772 | 팔로잉 772 | 리뷰 수 113")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            fetchPlaces()
        }
        .fullScreenCover(isPresented: $isUserViewActive) {
            UserView(isPresented: $isUserViewActive)
        }
        .fullScreenCover(isPresented: $isPlaceDetailViewPresented) {
            if let selectedPlace = selectedPlace {
                PlaceDetailView(placeId: selectedPlace.placeId) // placeId로 수정
            }
        }
    }

    private func fetchPlaces() {
        let urlString = "https://api.locavel.site/api/places/recommend-results?latitude=37.5665&longitude=126.9780" // Example coordinates
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(PlaceListResponse.self, from: data)
                    self.places = apiResponse.result
                    self.selectedPlace = self.places.randomElement() // Select a random place
                    if let selectedPlace = self.selectedPlace {
                        self.selectedImageURL = selectedPlace.reviewImgList.randomElement() // Select a random image URL
                    }
                } catch {
                    self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

