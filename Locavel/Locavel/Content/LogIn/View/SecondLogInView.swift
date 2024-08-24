import SwiftUI

struct SecondLogInView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var showContentView = false
    
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
                            Text("이메일").font(.title2).bold()
                            Text("을 입력해주세요.").font(.title3)
                        }
                        TextField("ex) Locavel@example.com", text: $viewModel.email)
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
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("확인")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 303, height: 46)
                        .background(ColorManager.AccentColor)
                        .cornerRadius(10)
                }
                .frame(width: 281, height: 51)
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .fullScreenCover(isPresented: $showContentView) {
            ContentView()
        }
        .onReceive(viewModel.$isLoggedIn) { isLoggedIn in
            if isLoggedIn {
                showContentView = true
            }
        }
    }
}

#Preview {
    SecondLogInView()
}
