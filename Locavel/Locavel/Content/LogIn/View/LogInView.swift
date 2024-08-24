import SwiftUI

struct LogInView: View {
    @StateObject private var naverAuth = NaverAuth()
    @State private var isKakaoLoggedIn = false
    @State private var showFirstSignUpView = false

    var body: some View {
        NavigationStack {
            VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                Image("Logo")
                    .resizable()
                    .frame(width: 183, height: 37)
                    .padding(.bottom)
                
                Text(" 로그인 / 회원가입 ")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                NavigationLink(destination: FirstSignUpView()) {
                    Text("이메일로 시작하기")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 281, height: 51)
                        .background(RoundedRectangle(cornerRadius: 10))
                }
                .frame(width: 281, height: 51)
                
                naverButton(isLoggedIn: $naverAuth.isLoggedIn)
                                
                kakaoButton(isLoggedIn: $isKakaoLoggedIn)
            }
            .padding()
        }
        .onChange(of: naverAuth.isLoggedIn) {
            if naverAuth.isLoggedIn {
                showFirstSignUpView = true
            }
        }
        .onChange(of: isKakaoLoggedIn) {
            if isKakaoLoggedIn {
                showFirstSignUpView = true
            }
        }
        .fullScreenCover(isPresented: $showFirstSignUpView) {
            FirstSignUpView()
        }
    }
}

#Preview {
    LogInView()
}
