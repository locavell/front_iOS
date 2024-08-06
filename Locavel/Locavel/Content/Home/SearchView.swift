//
//  SearchView.swift
//  Locavel
//
//  Created by 김의정 on 7/19/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

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
        }
        .font(.headline)
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchText = ""

    static var previews: some View {
        SearchBarView(searchText: $searchText)
    }
}
