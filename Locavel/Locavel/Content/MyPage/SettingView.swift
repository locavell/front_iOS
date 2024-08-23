import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Bar with Back Button
                HStack(spacing: -15) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(ColorManager.AccentColor)
                    }
                    .padding(.leading, 2)  // 왼쪽 여백 추가
                    
                    Spacer()
                    
                    Text("계정 설정")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom,50)
                
                // Menu Items
                VStack(spacing: 1) {
                    NavigationLink(destination: WishListSettingView()) {
                        MenuItem(title: "위시리스트", icon: "bookmark")
                    }
                    Divider()
                    NavigationLink(destination: ReviewSettingView()) {
                        MenuItem(title: "리뷰 관리", icon: "bubble.left")
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
            }
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

struct MenuItem: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(ColorManager.AccentColor)
                .frame(width: 32)
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 18))
                .foregroundColor(ColorManager.AccentColor)
        }
        .padding()
    }
}

#Preview {
    SettingView()
}
