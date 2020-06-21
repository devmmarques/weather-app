import UIKit

class WeatherListInteractor: WeatherListInputInteractorProtocol {
    
    weak var presenter: WeatherListOutPutInteractorProtocol?
    let service: WeatherServiceProtocol
    
    
    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func fetchWeather() {
        self.service.fetchWeather { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(weatherResponse):
                print(weatherResponse)
            case let .failure(error):
                print(error)
            }
        }
    }
}
