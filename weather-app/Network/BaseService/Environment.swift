import Foundation

struct Environment {
    
    private let configuration: Configuration
    private let apiKEY = "8a16668511a8a28ae19e4608f702f0eb"
    private let extensionIcon = "@2x.png"
    
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
    
    var baseURLImageString: String {
        switch configuration {
        case .development:
            return "https://openweathermap.org/img/wn/"
        default:
            return "https://openweathermap.org/img/wn/"
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
    
    var baseExtensionIcon: String {
        switch configuration {
        case .development:
            return self.extensionIcon
        default:
            return self.extensionIcon
        }
    }
}
