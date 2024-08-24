//
//  InterestRegionView.swift
//  Locavel
//
//  Created by 김의정 on 8/21/24.
//

import SwiftUI

struct InterestRegionView: View {
    @State private var regions: [Region] = []
    @State private var isEditing = false
    @State private var showAddRegionView = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "완료" : "편집하기")
                        .foregroundColor(isEditing ? .black : .gray)
                }
            }
            .padding()
            
            ScrollView {
                if isEditing {
                    HStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                        
                        Text("추가하기")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .onTapGesture {
                        showAddRegionView = true
                    }
                }
                
                ForEach(regions) { region in
                    HStack {
                        Image(region.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(region.name)
                                .font(.system(size: 16, weight: .bold))
                            Text("\(region.wishListCount)개의 위시리스트")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }
                        Spacer()
                        
                        if isEditing {
                            Button(action: {
                                deleteRegion(region)
                            }) {
                                Text("삭제")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                }
            }
        }
        .fullScreenCover(isPresented: $showAddRegionView) {
            AddRegionView(onAddRegions: addRegions)
        }
        .onAppear {
            loadRegions()
        }
    }
    
    func loadRegions() {
        regions = [
            Region(name: "강릉", imageName: "강릉", wishListCount: 17),
            Region(name: "속초", imageName: "강릉2", wishListCount: 17),
            Region(name: "천안", imageName: "강릉3", wishListCount: 17),
            Region(name: "수원", imageName: "지역4", wishListCount: 17),
            Region(name: "인천", imageName: "지역5", wishListCount: 17),
            Region(name: "부산", imageName: "지역6", wishListCount: 17),
            Region(name: "울산", imageName: "지역7", wishListCount: 17),
            Region(name: "광주", imageName: "지역8", wishListCount: 17),
            Region(name: "강남", imageName: "지역9", wishListCount: 17),
            Region(name: "연천", imageName: "지역10", wishListCount: 17),
        ]
    }
    
    func addRegions(_ newRegions: [String]) {
        for regionName in newRegions {
            let newRegion = Region(name: regionName, imageName: regionName, wishListCount: 0)
            regions.append(newRegion)
        }
    }
    
    func deleteRegion(_ region: Region) {
        regions.removeAll { $0.id == region.id }
    }
}

// Sample Data Model for Region
struct Region: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let wishListCount: Int
}
