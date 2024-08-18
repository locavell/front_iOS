//
//  RatingView.swift
//  Locavel
//
//  Created by 김의정 on 8/16/24.
//

import Foundation
import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("별점 (필수)")
                .font(.headline)
            HStack {
                ForEach(1..<6) { index in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(index <= rating ? Color.yellow : Color.gray)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            rating = index
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}
