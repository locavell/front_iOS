import Foundation
import Moya
import Combine

class SignUpViewModel: ObservableObject {
    private let provider = MoyaProvider<LoginAPI>()
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isSignUpSuccessful: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func signUp() {
        isLoading = true
        errorMessage = nil
        
        print("회원가입 시도: Email: \(email), Name: \(name), Nickname: \(nickname)")
        
        provider.request(.signup(email: email, password: password, username: name, nickname: nickname)) { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let response):
                print("HTTP 상태 코드: \(response.statusCode)")
                let responseString = String(data: response.data, encoding: .utf8)
                print("서버 응답 데이터: \(responseString ?? "응답 데이터 없음")")
                
                if 200..<300 ~= response.statusCode {
                    self?.isSignUpSuccessful = true
                    print("회원가입 성공")
                } else {
                    self?.errorMessage = "회원가입에 실패했습니다. 다시 시도해주세요."
                    print("회원가입 실패: 상태 코드 \(response.statusCode)")
                }
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                print("회원가입 요청 실패: \(error.localizedDescription)")
            }
        }
    }
}
