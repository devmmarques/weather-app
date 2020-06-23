import UIKit

class WeatherListInteractor: WeatherListInputInteractorProtocol {
    
    weak var presenter: WeatherListOutPutInteractorProtocol?
    var typeUnitTemperature: UnitTemperature = .celsius
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
        
        if let parameters = self.getParameters() {
            self.service.fetchWeather(parameters: parameters) { [weak self] result in
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
        } else {
            self.listWeather = [.error(.empty(.location))]
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
        guard let location = self.getLocationUser() else { return nil}
        var parameters = location
        parameters["appid"] = apiKey
        parameters["cnt"] = 50
        return parameters
    }
    
    private func getLocationUser() -> [String: Any]? {
        return LocationManager.shared.locationParameters
    }
    
    func changeUnitTemperature() {
        switch self.typeUnitTemperature {
        case .celsius:
            self.typeUnitTemperature = .fahrenheit
        case .fahrenheit:
            self.typeUnitTemperature = .celsius
        default:
            self.typeUnitTemperature = .celsius
        }
        
        self.presenter?.showUnitTemperature()
    }
}
