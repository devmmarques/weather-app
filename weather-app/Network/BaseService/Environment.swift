import Foundation

struct Environment {
    
    private let configuration: Configuration
    private let apiKEY = "8a16668511a8a28ae19e4608f702f0eb"
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    static var current: Environment {
        return Environment(configuration: .current())
    }
}

extension Environment {
    var baseURLString: String {
        switch configuration {
        case .development:
            return "https://api.openweathermap.org"
        default:
            return "https://api.openweathermap.org"
        }
    }
    
    var baseApiKey: String {
        switch configuration {
        case .development:
            return self.apiKEY
        default:
            return self.apiKEY
        }
    }
}
