import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Bar with Back Button
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(ColorManager.AccentColor)
                }
                Spacer()
                
                Text("계정 설정")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                Spacer()
            }
            .padding(.bottom,50)
            
            // Menu Items
            VStack(spacing: 1) {
                MenuItem(title: "위시리스트", icon: "bookmark")
                Divider()
                MenuItem(title: "리뷰 관리", icon: "bubble.left")
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
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
