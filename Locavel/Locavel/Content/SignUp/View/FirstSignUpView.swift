import SwiftUI

struct FirstSignUpView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var shouldShowSignUpView = false
    
    var body: some View {
        VStack(spacing: 0) {
            // 닫기 버튼을 포함한 HStack
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding()
                }
                .padding(.leading, 8)
                
                Spacer()
            }
            
            // 나머지 콘텐츠
            VStack(spacing: 20) {
                Image("Logo")
                    .resizable()
                    .frame(width: 183, height: 37)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom,80)
                    .padding(.top,80)
                
                VStack(spacing: 10) {
                    HStack(spacing: 0) {
                        Text("이름")
                            .font(.title2)
                            .bold()
                        Text("을 입력해주세요.")
                            .font(.title3)
                    }
                    
                    TextField("이름 입력", text: $name)
                        .textFieldStyle(CustomTextFieldStyle())
                }
                
                VStack(spacing: 20) {
                    HStack(spacing: 0) {
                        Text("이메일")
                            .font(.title2)
                            .bold()
                        Text("을 입력해주세요.")
                            .font(.title3)
                    }
                    
                    TextField("이메일 입력", text: $email)
                        .textFieldStyle(CustomTextFieldStyle())
                }
                
                VStack(spacing: 10) {
                    HStack(spacing: 0) {
                        Text("비밀번호")
                            .font(.title2)
                            .bold()
                        Text("를 입력해주세요.")
                            .font(.title3)
                    }
                    
                    SecureField("비밀번호 입력", text: $password)
                        .textFieldStyle(CustomTextFieldStyle())
                }
                
                Button(action: {
                    shouldShowSignUpView = true
                }) {
                    Text("확인")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 303, height: 46)
                        .background(ColorManager.AccentColor)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 30)
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
        .fullScreenCover(isPresented: $shouldShowSignUpView) {
            SignUpView()
        }
    }
}

#Preview {
    FirstSignUpView()
}
