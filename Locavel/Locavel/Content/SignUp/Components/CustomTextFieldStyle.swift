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
                .foregroundColor(Color(.systemBackground))
                .cornerRadius(8)
                .frame(width: 303, height: 46)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1))
                
            
            // 텍스트필드
            configuration
                .font(.body)
                .background(Color(.systemBackground))
                .padding()
                .frame(width: 303, height: 46)
        }
    }
}
