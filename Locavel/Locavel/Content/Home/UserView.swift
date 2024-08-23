import SwiftUI

struct UserView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Section
                    VStack(spacing: 10) {
                        HStack {
                            // Profile Image
                            Image("profileImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // Username and other details
                        VStack(alignment: .leading, spacing: 5) {
                            Text("dsknjlvc")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("현지인")
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.orange)
                                Text("여행객")
                                Image(systemName: "person.fill")
                            }
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            
                            // Social links or status
                            Text("Revolutionize Your Online Experience with")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 10) {
                                Text("@Resvshreiusa")
                                    .foregroundColor(.blue)
                            }
                            .font(.subheadline)
                        }
                        .padding(.horizontal)
    
                    }
                    .padding(.top)
                    
                    // Visited Places Section
                    VStack(alignment: .leading) {
                        Text("dsknjlvc님이 방문한 곳")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack {
                            Text("푸드")
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding(.horizontal)
                            
                            Text("스팟")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text("액티비티")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Button(action: {
                                // Show all action
                            }) {
                                Text("전체보기")
                                    .font(.footnote)
                                    .underline()
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                        }
                        .padding(.vertical)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<3) { _ in
                                    VStack(alignment: .leading) {
                                        Image("restaurantImage")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150, height: 150)
                                            .clipped()
                                            .overlay(
                                                HStack {
                                                    Spacer()
                                                    VStack {
                                                        Button(action: {
                                                            // Wishlist action
                                                        }) {
                                                            Image(systemName: "heart.fill")
                                                                .foregroundColor(.red)
                                                                .padding()
                                                        }
                                                        Spacer()
                                                    }
                                                }
                                            )
                                        
                                        Text("어니더레벨")
                                            .font(.headline)
                                            .padding(.vertical, 5)
                                        
                                        Text("맛난 회가 생각날 때 추천하는 곳")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                        
                                        Text("서울특별시 중구 을지로 12")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                        
                                        HStack(spacing: 2) {
                                            ForEach(0..<5) { index in
                                                Image(systemName: index < 4 ? "star.fill" : "star")
                                                    .foregroundColor(index < 4 ? .yellow : .gray)
                                            }
                                            Text("4.0")
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .frame(width: 150)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                    
                    // Calendar Section
                    VStack(alignment: .leading) {
                        Text("dsknjlvc님의 기록")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        CalendarView()
                            .frame(height: 300)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 50)
            }
            .navigationBarItems(leading: Button(action: {
                isPresented = false
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(ColorManager.AccentColor)
                    .font(.system(size: 20))
            })
            .navigationBarTitle("dsknjlvc님의 정보", displayMode: .inline)
        }
    }
}
