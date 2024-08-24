import SwiftUI

struct OpeningView: View {

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
                
                Button(action: {}) {
                    Text("전화번호로 시작하기")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 281, height: 51)
                        .background(RoundedRectangle(cornerRadius: 10))
                }
                .frame(width: 281, height: 51)
                
            }
            .padding()
        }
    }
}

#Preview {
    OpeningView()
}
