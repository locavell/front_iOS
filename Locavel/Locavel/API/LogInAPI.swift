import Moya
import Foundation

enum LoginAPI {
    case sociallogin
    case signup(email: String, password: String)
}

extension LoginAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.locavel.site")!
    }
    
    var path: String {
        switch self {
        case .sociallogin:
            return "/api/auth/social-login"
        case .signup:
            return "/api/auth/sign-up"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .sociallogin:
            return .requestPlain
        case .signup(email: let email, password: let password):
            let parameters: [String: Any] = [
                "email": email,
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
