//
//  CustomTextField.swift
//  Locavel
//
//  Created by 김경서 on 8/22/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color.green)
                .cornerRadius(8)
                .frame(height: 46)
            
            // 텍스트필드
            configuration
                .font(.title)
                .padding()
        }
    }
}
