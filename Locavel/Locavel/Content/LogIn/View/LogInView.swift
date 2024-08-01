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
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue)) // 버튼의 배경 설정
            }
            .frame(width: 281, height: 51) // 버튼의 크기 설정
            
            Button(action: {}) {
                HStack(spacing: 10) {
                    Image("naver")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("네이버로 시작하기")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding() // 내부 여백 설정
                .frame(width: 281, height: 51) // 버튼의 크기 설정
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.green)) // 버튼의 배경 설정
            }
            .frame(width: 281, height: 51) // 버튼의 크기 설정
            
            Button(action: {}) {
                HStack(spacing: 10) {
                    Image("kakao")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("카카오로 시작하기")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .padding() // 내부 여백 설정
                .frame(width: 281, height: 51) // 버튼의 크기 설정
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.yellow)) // 버튼의 배경 설정
            }
            .frame(width: 281, height: 51) // 버튼의 크기 설정
        }
        .padding()
    }
}

#Preview {
    LogInView()
}
