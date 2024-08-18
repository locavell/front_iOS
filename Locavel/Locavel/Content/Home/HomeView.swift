//
//  HomeView.swift
//  Locavel
//
//  Created by 박희민 on 8/8/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedLocation: String = ""

    var body: some View {
        VStack {
            Text("Selected Location: \(selectedLocation)")
                .padding()
            NavigationLink(destination: EnrollLocationView()) {
                Text("Enroll Location")
            }
        }
        .onAppear {
            // Perform any actions needed with the selected location
        }
    }
}

#Preview {
    HomeView()
}
