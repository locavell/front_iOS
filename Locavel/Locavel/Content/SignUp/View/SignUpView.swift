import SwiftUI

struct SignUpView: View {
    
    @State private var nickname: String = ""
    @State private var showEnrollLocationView = false
    private let maxLength: Int = 20
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 183, height: 37)
            
            Spacer().frame(height: 40)
            
            HStack (spacing: 0) {
                Text("닉네임")
                    .font(.title2)
                    .bold()
                Text("을 입력해주세요.")
                    .font(.title2)
            }
            
            Spacer().frame(height: 20)
            
            TextField("닉네임 입력", text: $nickname)
                .textFieldStyle(CustomTextFieldStyle())
            
            Spacer().frame(height: 20)
            
            Button(action: {
                showEnrollLocationView = true
            }) {
                Text("확인")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 303, height: 46)
                    .background(ColorManager.AccentColor)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $showEnrollLocationView) {
                EnrollLocationView()
            }
            .frame(width: 281, height: 51)
        }
    }
}

#Preview {
    SignUpView()
}
