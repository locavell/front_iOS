//
//  SearchView.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//

//import SwiftUI
//
//struct SearchBarView: View {
//    @Binding var searchText: String
//    var onSearch: (String) -> Void
//    
//    var body: some View {
//        HStack {
//            Image(systemName: "magnifyingglass")
//                .foregroundColor(
//                    searchText.isEmpty ?
//                    Color.black : Color.blue)
//            TextField("어디로 가시나요?", text: $searchText)
//                .autocorrectionDisabled(true)
//                .foregroundColor(Color.black)
//                .overlay(
//                    Image(systemName: "xmark.circle.fill")
//                        .padding()
//                        .offset(x: 10)
//                        .foregroundColor(Color.primary)
//                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
//                        .onTapGesture {
//                            searchText = ""
//                            UIApplication.shared.endEditing()
//                        }
//                    , alignment: .trailing
//                )
//                .onSubmit {
//                    onSearch(searchText)
//                }
//            Button(action: {
//                onSearch(searchText)
//            }) {
//                Text("검색")
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 7)
//                    .background(Color("AccentColor"))
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            
//        }
//        .font(.headline)
//        .padding()
//    }
//}
//extension UIApplication {
//    func endEditing() {
//        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}


import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.black : Color.blue)
            TextField("어디로 가시나요?", text: $searchText)
                .autocorrectionDisabled(true)
                .foregroundColor(Color.black)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.primary)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    , alignment: .trailing
                )
                .onSubmit {
                }
            Button(action: {
            }) {
                Text("검색")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
        }
        .font(.headline)
        .padding()
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
