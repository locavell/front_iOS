import SwiftUI

struct FirstSignUpView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 183, height: 37)
                
                Spacer().frame(height: 100)
                
                HStack (spacing:0){
                    Text("이름")
                        .font(.title2)
                        .bold()
                    Text("을 입력해주세요.")
                        .font(.title3)
                }
                
                Spacer().frame(height: 20)
                
                TextField("이름 입력", text: $name)
                    .textFieldStyle(CustomTextFieldStyle())
                
                
                Spacer().frame(height: 20)
                
                HStack (spacing:0){
                    Text("이메일")
                        .font(.title2)
                        .bold()
                    Text("을 입력해주세요.")
                        .font(.title3)
                }
                
                Spacer().frame(height: 20)
                
                TextField("이메일 입력", text: $email)
                    .textFieldStyle(CustomTextFieldStyle())
                
                
                Spacer().frame(height: 20)
                
                HStack (spacing:0){
                    Text("비밀번호")
                        .font(.title2)
                        .bold()
                    Text("를 입력해주세요.")
                        .font(.title3)
                }
                
                Spacer().frame(height: 20)
                
                SecureField("비밀번호 입력", text: $password)
                    .textFieldStyle(CustomTextFieldStyle())
                
                
                Spacer().frame(height: 50)
                
                NavigationLink(destination: SignUpView()) {
                    Text("확인")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white) // 텍스트 색상
                        .frame(width: 303, height: 46) // 버튼의 크기 설정
                        .background(ColorManager.AccentColor) // 배경 색상
                        .cornerRadius(10) // 모서리 둥글기
                }
                .frame(width: 281, height: 51)
            }
        }
    }
}

#Preview {
    FirstSignUpView()
}
