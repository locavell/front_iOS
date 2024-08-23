import SwiftUI

struct FirstSignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 183, height: 37)
                
                Spacer().frame(height: 100)
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 0) {
                            Text("이름").font(.title2).bold()
                            Text("을 입력해주세요.").font(.title3)
                        }
                        TextField("이름 입력", text: $viewModel.name)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 0) {
                            Text("이메일").font(.title2).bold()
                            Text("을 입력해주세요.").font(.title3)
                        }
                        TextField("이메일 입력", text: $viewModel.email)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 0) {
                            Text("비밀번호").font(.title2).bold()
                            Text("를 입력해주세요.").font(.title3)
                        }
                        SecureField("비밀번호 입력", text: $viewModel.password)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                }
                
                Spacer().frame(height: 50)
                
                NavigationLink(destination: SignUpView(viewModel: viewModel)) {
                    Text("확인")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 303, height: 46)
                        .background(ColorManager.AccentColor)
                        .cornerRadius(10)
                }
                .frame(width: 281, height: 51)
            }
        }
    }
}
