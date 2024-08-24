import SwiftUI
import Moya

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
    
    struct CalendarView: View {
        @State private var visitDays: [String] = []
        @State private var year = Calendar.current.component(.year, from: Date())
        @State private var month = Calendar.current.component(.month, from: Date())
        
        var body: some View {
            VStack {
                HStack {
                    Text("\(String(format: "%d", year)).\(String(format: "%02d", month))")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            changeMonth(by: -1)
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {
                            // Next month action
                            changeMonth(by: 1)
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
                    ForEach(1..<daysInMonth() + 1, id: \.self) { day in
                        let dayString = "\(year)-\(String(format: "%02d", month))-\(String(format: "%02d", day))"
                        Text("\(day)")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(visitDays.contains(dayString) ? Color.blue.opacity(0.7) : Color.white)
                            .cornerRadius(8)
                            .overlay(
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 8, height: 8)
                                    .offset(x: 12, y: -12)
                                    .opacity(visitDays.contains(dayString) ? 1 : 0)
                            )
                    }
                }
                .padding(.top)
            }
            .onAppear {
                fetchVisitDays()
            }
        }
        
        private func fetchVisitDays() {
            let provider = MoyaProvider<MyPageAPI>()
            provider.request(.getVisitDays(year: year, month: month)) { result in
                switch result {
                case .success(let response):
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                        if let result = json?["result"] as? [String: Any],
                           let visitDayList = result["visitDayList"] as? [String] {
                            self.visitDays = visitDayList
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                case .failure(let error):
                    print("Failed to fetch visit days: \(error.localizedDescription)")
                }
            }
        }
        
        private func changeMonth(by value: Int) {
            var newDate = Calendar.current.date(byAdding: .month, value: value, to: Calendar.current.date(from: DateComponents(year: year, month: month))!)!
            year = Calendar.current.component(.year, from: newDate)
            month = Calendar.current.component(.month, from: newDate)
            fetchVisitDays()
        }
        
        private func daysInMonth() -> Int {
            let dateComponents = DateComponents(year: year, month: month)
            let calendar = Calendar.current
            let date = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .day, in: .month, for: date)!
            return range.count
        }
    }

    enum MyPageAPI: TargetType {
        case getVisitDays(year: Int, month: Int)
        
        var baseURL: URL {
            return URL(string: "https://api.locavel.site")!
        }
        
        var path: String {
            switch self {
            case .getVisitDays:
                return "/api/users/mypage/calendar"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var task: Task {
            switch self {
            case let .getVisitDays(year, month):
                return .requestParameters(parameters: ["year": year, "month": month], encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]? {
            var headers = ["Content-Type": "application/json"]
            let accessToken = TokenManager.shared.accessToken
            headers["Authorization"] = "Bearer \(accessToken)"
            return headers
        }
        
        var sampleData: Data {
            return Data()
        }
    }
}


