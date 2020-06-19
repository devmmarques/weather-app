import Foundation

struct API {
    
    enum Weather {
        case fetchWeather
        
        var value: String {
            let baseURL = Environment.current.baseURLString
            
            switch self {
            case .fetchWeather:
                return "\(baseURL)/data/2.5/weather?lat=-23.6787235&lon=-46.6872758&appid=8a16668511a8a28ae19e4608f702f0eb"
            }
        }
    }
    
}
