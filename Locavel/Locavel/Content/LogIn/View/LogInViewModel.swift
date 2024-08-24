import Foundation
import Moya
import Combine
import CombineMoya

class LoginViewModel: ObservableObject {
    private let provider = MoyaProvider<LoginAPI>()
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func login() {
        print("Login attempt with email: \(email), password: \(password)")
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "이메일과 비밀번호를 입력해주세요."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        provider.requestPublisher(.login(email: email, password: password))
            .map(LoginResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.handleLoginResponse(response)
            }
            .store(in: &cancellables)
    }
    
    private func handleLoginResponse(_ response: LoginResponse) {
        
        print("Login response: \(response)")
        // 로그인 응답 처리
        if response.success {
            // 토큰 저장
            UserDefaults.standard.set(response.token, forKey: "authToken")
            isLoggedIn = true
        } else {
            errorMessage = response.message
        }
    }
}

// 서버 응답을 파싱하기 위한 구조체
struct LoginResponse: Codable {
    let success: Bool
    let message: String
    let token: String?
}
