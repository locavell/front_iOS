import SwiftUI

struct SignUpView: View {
    
    @State private var name: String = ""
    private let maxLength: Int = 20
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 183, height: 37)
            
            Spacer().frame(height: 40)
            
            Text("닉네임을 입력해주세요!")
                .font(.title2)
            
            Spacer().frame(height: 20)
            
            TextField("닉네임 입력", text: $name)
                .textFieldStyle(CustomTextFieldStyle())
                
            
            Spacer().frame(height: 20)
            
            Button(action: {
                // "확인" 버튼 클릭 시 동작
            }) {
                Text("확인")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 303, height: 46)
                    .background(RoundedRectangle(cornerRadius: 10))
            }
            .frame(width: 281, height: 51)
        }
    }
}

#Preview {
    SignUpView()
}
