import UIKit

class WeatherListInteractor: WeatherListInputInteractorProtocol {

    weak var presenter: WeatherListOutPutInteractorProtocol?
    let service: WeatherServiceProtocol
    
    var listWeather: [ListCellType<Weather>] = [] {
        didSet {
            self.presenter?.showWeather()
        }
    }
    
    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func fetchWeather() {
        self.listWeather = [.loading];
        self.service.fetchWeather(parameters: self.getParameters()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(weatherResponse):
                if weatherResponse.list.isEmpty {
                   self.listWeather = [.error(.empty(.weather))]
                } else {
                    self.listWeather = weatherResponse.list.map({
                        return ListCellType.cell(Weather(response: $0))
                    })
                }
                self.presenter?.showWeather()
            case let .failure(error):
                self.listWeather = [.error(error)]
            }
        }
    }
    
    func countListWeather() -> Int {
        return self.listWeather.count
    }
    
    func getWeather(with index: Int) -> ListCellType<Weather> {
        return self.listWeather[index]
    }
    
    private func getParameters() -> [String: Any]? {
        let apiKey = Environment.current.baseApiKey
        var parameters = self.getLocationUser()
        parameters?["appid"] = apiKey
        parameters?["cnt"] = 50
        return parameters
    }
    
    private func getLocationUser() -> [String: Any]? {
        return LocationManager.shared.locationParameters
    }
}
