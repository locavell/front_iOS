//
//  RegisterPlaceView.swift
//  Locavel
//
//  Created by 김의정 on 8/16/24.
//

import Foundation
import SwiftUI

struct RegisterPlaceView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // 장소 등록에 필요한 상태 변수들
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var telephoneNumber: String = ""
    @State private var selectedCategory: String = ""
    @State private var rating: Int = 0
    @State private var isSubmitting: Bool = false // 등록 중 상태 관리

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // 상단의 사진 등록 버튼과 이미지
                        ZStack(alignment: .bottom) {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)

                            Button(action: {
                                // 사진 등록 로직
                            }) {
                                Text("사진 등록")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .frame(width: 130, height: 37)
                                    .background(.white)
                                    .foregroundColor(Color("AccentColor"))
                                    .cornerRadius(50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color("AccentColor"), lineWidth: 1)
                                    )
                            }
                            .padding(.bottom, 20)
                            
                        }
                        .padding()

                        // 장소명 입력 필드
                        VStack(alignment: .leading) {
                            Text("장소명 (필수)")
                                .font(.headline)
                            TextField("장소 이름을 말해주세요", text: $name)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        // 별점 입력
                        RatingView(rating: $rating)

                        // 카테고리 선택
                        CategorySelectionView(selectedCategory: $selectedCategory)

                        // 위치 확인하기 필드
                        VStack(alignment: .leading) {
                            Text("위치 확인하기")
                                .font(.headline)
                            TextField("주소 입력", text: $address)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        // 전화번호 입력 필드
                        VStack(alignment: .leading) {
                            Text("전화번호")
                                .font(.headline)
                            TextField("전화번호 입력", text: $telephoneNumber)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        Spacer()
                            .frame(height: 20)
                    }
                    .padding()
                }
                
                // 하단 고정된 버튼
                VStack {
                    Spacer()
                    Button(action: {
                        submitPlace() // 등록하기 로직 호출
                    }) {
                        Text(isSubmitting ? "등록 중..." : "등록하기")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 140, height: 40)
                            .background(Color("AccentColor"))
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .padding(.horizontal)
                    }
                    .disabled(isSubmitting) // 요청 중일 때 버튼 비활성화
                }
            }
            .navigationTitle("새로 등록하기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            })
        }
    }

    // 등록하기 버튼을 눌렀을 때 호출되는 함수
    private func submitPlace() {
        guard !name.isEmpty, !address.isEmpty, !selectedCategory.isEmpty, rating > 0 else {
            // 필수 필드가 비어있으면 알림 표시
            print("모든 필드를 채워주세요.")
            return
        }

        isSubmitting = true

        let newPlace = [
            "name": name,
            "address": address,
            "category": selectedCategory.lowercased(),
            "telephoneNumber": telephoneNumber,
            "rating": rating
        ] as [String : Any]

        guard let url = URL(string: "https://api.locavel.site/api/places") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newPlace, options: [])
        } catch {
            print("Error encoding JSON: \(error)")
            isSubmitting = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isSubmitting = false
            }

            if let error = error {
                print("Error during request: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }

            DispatchQueue.main.async {
                // 성공적으로 등록 후, 화면을 닫거나 알림 표시
                presentationMode.wrappedValue.dismiss()
            }
        }.resume()
    }
}
