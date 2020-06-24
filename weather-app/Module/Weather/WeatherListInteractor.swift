import UIKit

class WeatherListInteractor: WeatherListInputInteractorProtocol {
    
    weak var presenter: WeatherListOutPutInteractorProtocol?
    var typeUnitTemperature: UnitTemperature = .celsius
    let service: WeatherServiceProtocol
    
    private var listWeatherCell: [ListCellType<Weather>] = [] {
        didSet {
            self.presenter?.showWeather()
        }
    }
    
    private var listWeather: [Weather] = []
    
    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func fetchWeather() {
        self.listWeatherCell = [.loading];
        
        if let parameters = self.getParameters() {
            self.service.fetchWeather(parameters: parameters) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(weatherResponse):
                    if weatherResponse.list.isEmpty {
                       self.listWeatherCell = [.error(.empty(.weather))]
                    } else {
                        self.listWeatherCell = weatherResponse.list.map({
                            self.listWeather.append(Weather(response: $0))
                            return ListCellType.cell(Weather(response: $0))
                        })
                    }
                    self.presenter?.showWeather()
                case let .failure(error):
                    self.listWeatherCell = [.error(error)]
                }
            }
        } else {
            self.listWeatherCell = [.error(.empty(.location))]
        }
    }
    
    func countListWeather() -> Int {
        return self.listWeatherCell.count
    }
    
    func getWeather() -> [Weather] {
       return listWeather
    }
    
    func getWeather(with index: Int) -> ListCellType<Weather> {
        return self.listWeatherCell[index]
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
