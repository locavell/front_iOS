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
            .tryMap { response -> LoginResponse in
                let json = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                print("Raw JSON response: \(json ?? [:])")
                return try JSONDecoder().decode(LoginResponse.self, from: response.data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                    print("Error details: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.handleLoginResponse(response)
            }
            .store(in: &cancellables)
    }
    
    struct LoginResponse: Codable {
        let refreshToken: String
        let accessToken: String
    }
    
    private func handleLoginResponse(_ response: LoginResponse) {
        print("Login successful")
        // 토큰 저장
        UserDefaults.standard.set(response.accessToken, forKey: "accessToken")
        UserDefaults.standard.set(response.refreshToken, forKey: "refreshToken")
        isLoggedIn = true
    }
}
