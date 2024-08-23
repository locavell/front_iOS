import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    @State private var showEnrollLocationView = false
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 183, height: 37)
            
            Spacer().frame(height: 40)
            
            HStack(spacing: 0) {
                Text("닉네임")
                    .font(.title2)
                    .bold()
                Text("을 입력해주세요.")
                    .font(.title2)
            }
            
            Spacer().frame(height: 20)
            
            TextField("닉네임 입력", text: $viewModel.nickname)
                .textFieldStyle(CustomTextFieldStyle())
            
            Spacer().frame(height: 20)
            
            Button(action: {
                viewModel.signUp()
            }) {
                Text("확인")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 303, height: 46)
                    .background(ColorManager.AccentColor)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isLoading)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .alert("회원가입 성공", isPresented: $viewModel.isSignUpSuccessful) {
            Button("확인") {
                showEnrollLocationView = true
            }
        }
        .fullScreenCover(isPresented: $showEnrollLocationView) {
            EnrollLocationView()
        }
    }
}
