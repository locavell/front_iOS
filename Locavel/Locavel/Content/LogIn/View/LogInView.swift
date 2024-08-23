import SwiftUI

struct LogInView: View {
    @ObservedObject var naverAuth = NaverAuth() // 네이버 로그인 상태를 관찰
    @State private var isKakaoLoggedIn = false // 카카오 로그인 상태

    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 183, height: 37)
                    .padding(.bottom)
                
                Text(" 로그인 / 회원가입 ")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Button(action: {}) {
                    Text("전화번호로 시작하기")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 281, height: 51) // 버튼의 크기 설정
                        .background(RoundedRectangle(cornerRadius: 10)) // 버튼의 배경 설정
                }
                .frame(width: 281, height: 51) // 버튼의 크기 설정
                
                naverButton(isLoggedIn: $naverAuth.isLoggedIn) // 네이버 로그인 상태 연동
                
                kakaoButton(isLoggedIn: $isKakaoLoggedIn) // 카카오 로그인 상태 연동
            }
            .padding()
            .navigationDestination(isPresented: $naverAuth.isLoggedIn) {
                FirstSignUpView()
            }
            .navigationDestination(isPresented: $isKakaoLoggedIn) {
                FirstSignUpView()
            }
        }
    }
}


#Preview {
    LogInView()
}
