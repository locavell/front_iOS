import SwiftUI

struct LogInView: View {
    var body: some View {
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
            
            naverButton()
            
            kakaoButton()
        }
        .padding()
    }
}

#Preview {
    LogInView()
}
