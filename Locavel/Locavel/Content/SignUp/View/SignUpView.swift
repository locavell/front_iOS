import SwiftUI

struct SignUpView: View {
    
    @State private var nickname: String = ""
    private let maxLength: Int = 20
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 183, height: 37)
                
                Spacer().frame(height: 40)
                
                HStack (spacing: 0){
                    Text("닉네임")
                        .font(.title2)
                        .bold()
                    Text("을 입력해주세요.")
                        .font(.title2)
                }
                
                Spacer().frame(height: 20)
                
                TextField("닉네임 입력", text: $nickname)
                    .textFieldStyle(CustomTextFieldStyle())
                
                
                Spacer().frame(height: 20)
                
                NavigationLink(destination: EnrollLocationView()) {
                    Text("확인")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white) // 텍스트 색상
                        .frame(width: 303, height: 46) // 버튼의 크기 설정
                        .background(ColorManager.AccentColor) // 배경 색상
                        .cornerRadius(10) // 모서리 둥글기
                }
                .frame(width: 281, height: 51)
            }
        }
    }
}

#Preview {
    SignUpView()
}
