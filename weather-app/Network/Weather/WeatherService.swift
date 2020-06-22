import Foundation

protocol WeatherServiceProtocol {
    typealias WeatherResult = Result<WeatherMapResponseModel, WebserviceError>
    func fetchWeather(parameters: [String: Any]?, completion: @escaping (WeatherResult) -> Void)
}

final class WeatherService: NSObject, WeatherServiceProtocol {
    
    let service: Webservice

    init(service: Webservice = BaseWebservice()) {
        self.service = service
    }
    
    func fetchWeather(parameters: [String: Any]?, completion: @escaping (WeatherResult) -> Void) {
        guard let parameter = parameters else { return }
        
        self.service.request(urlString: API.Weather.fetchWeather.value, method: .get,
                             parameters: parameter) { (result: WeatherResult) in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
