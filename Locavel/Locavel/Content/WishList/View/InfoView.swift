//
//  InfoView.swift
//  testbaki
//
//  Created by 박희민 on 7/18/24.
//

import SwiftUI

struct InfoView: View {
    @Binding var selectedTab: Int
    var tests: tapInfo
    
    var body: some View {
        
            switch tests {
            case .food:
                FoodView(selectedTab: $selectedTab)
            case .spot:
                SpotView()
            case .activity:
                ActivityView()
            }
        
    }
}
//
//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoView(tests: .food)
//    }
//}
