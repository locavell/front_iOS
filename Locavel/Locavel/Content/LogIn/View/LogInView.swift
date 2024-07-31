import SwiftUI

struct LogInView: View {
    var body: some View {
        VStack {
            
            
            Text(" 로그인 / 회원가입 ")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            Button(action: {}, label: {
                Text("전화번호로 시작하기")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 281, height: 51)
                    )
            })
            .frame(width: 281, height: 51)
            
            Button(action: {}, label: {
                Text("네이버로 시작하기")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green)
                            .frame(width: 281, height: 51)
                    )
            })
            .frame(width: 281, height: 51)
            
            Button(action: {}, label: {
                Text("카카오로 시작하기")
                    .font(.headline)
                    .frame(maxWidth: .infinity)                    .padding()
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.yellow)
                            .frame(width: 281, height: 51)
                    )
            })
            .frame(width: 281, height: 51)
        }
    }
}

#Preview {
    LogInView()
}
