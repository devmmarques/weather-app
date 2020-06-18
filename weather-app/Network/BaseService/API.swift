import Foundation

struct API {
    
    enum Weather {
        case fetchWeather
        
        var value: String {
            let baseURL = Environment.current.baseURLString
            
            switch self {
            case .fetchWeather:
                return "\(baseURL)/data/2.5/weather"
            }
        }
    }
    
}
