import Foundation
import Alamofire
@testable import weather_app

enum MockWebserviceType {
    case searchWeather
    case unexpectedError
}

final class MockWebservice: Webservice {
    
    let type: MockWebserviceType
    
    init(type: MockWebserviceType) {
        self.type = type
    }
    
    func request<T: Codable>(urlString: String,
                             method: HTTPMethod,
                             parameters: [String: Any],
                             headers: [String: String],
                             encoding: ParameterEncoding,
                             completion: @escaping (Swift.Result<T, WebserviceError>) -> Void) {
        switch type {
        case .unexpectedError:
            completion(.failure(.unexpected))
        default:
            let jsonDecoder = JSONDecoder()
            let object = try! jsonDecoder.decode(T.self, from: data)
            completion(.success(object))
        }
        
    }
}

extension MockWebservice {
    var data: Data {
        let path: String
        switch type {
        case .searchWeather:
            path = Bundle(for: MockWebservice.self).path(forResource: "weather", ofType: "json")!
        case .unexpectedError:
            fatalError("Unexpected error should return any data")
        }
        let fileURL = URL(fileURLWithPath: path)
        return try! Data(contentsOf: fileURL)
    }
}
