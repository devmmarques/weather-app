import Foundation
import Alamofire

extension ParameterEncoding {
    var alamofireEncoding: Alamofire.ParameterEncoding {
        switch self {
        case .json:
            return JSONEncoding.default
        case .queryString:
            return URLEncoding.queryString
        default:
            return URLEncoding.default
        }
    }
}

struct BaseWebservice: Webservice {
    private let manager = DefaultSessionManager()
    
    func request<T: Codable>(urlString: String,
                             method: HTTPMethod,
                             parameters: [String: Any],
                             headers: [String: String],
                             encoding: ParameterEncoding,
                             completion: @escaping (Swift.Result<T, WebserviceError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            return completion(.failure(.malformedURL))
        }
        
        let request = manager.request(url, method: method,
                                      parameters: parameters,
                                      encoding: encoding.alamofireEncoding,
                                      headers: headers)
        
        request
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let object = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(object))
                    } catch {
                        completion(.failure(.unparseable))
                    }
                case .failure(let error):
                    let statusCode = response.response?.statusCode
                    self.handleFailure(error: error, statusCode: statusCode, completion: completion)
                }
        }
    }
    
    private func handleFailure<T>(error: Error, statusCode: Int?,
                                  completion: @escaping (Swift.Result<T, WebserviceError>) -> Void) {
        if let urlError = error as? URLError {
            return completion(.failure(self.handleURLError(error: urlError)))
        }
        
        guard let statusCode = statusCode else {
            return completion(.failure(.unexpected))
        }
        
        completion(.failure(self.handleHTTPError(statusCode: statusCode)))
    }
    
    private func handleURLError(error: URLError) -> WebserviceError {
        switch error.code {
        case .notConnectedToInternet:
            return .notConnectedToInternet
        case .timedOut:
            return .timedOut
        default:
            return .unexpected
        }
    }
    
    private func handleHTTPError(statusCode: Int) -> WebserviceError {
        guard let error = HTTPStatusCode(rawValue: statusCode) else {
            return .unexpected
        }
        
        switch error {
        case .unauthorized:
            return .unauthorized
        case .internalServerError:
            return .internalServerError
        case .forbidden:
            return .forbidden
        }
    }
}
