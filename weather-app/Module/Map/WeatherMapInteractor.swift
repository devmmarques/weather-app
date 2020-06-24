import UIKit
import MapKit

final class WeatherMapInteractor: WeatherMapInputInteractorProtocol {
    
    var presenter: WeatherMapOutPutInteractorProtocol?
    
    var weathers: [Weather]
    
    var typeUnitTemperature: UnitTemperature = .celsius
    
    init(weathers: [Weather]) {
        self.weathers = weathers
    }
    
    func fetchWeathers() {
        var listWeatherMap: [WeatherMap] = []
        
        for weather in weathers {
            var iconUrl = ""
            if let iconName = weather.weather.first?.icon {
                iconUrl = Environment.current.baseURLImageString + "\(iconName)" + Environment.current.baseExtensionIcon
            }
            
            let weatherMap = WeatherMap(title: weather.name, locationName: weather.name, temp: weather.main.temp, iconUrl: iconUrl, unitTemp: self.typeUnitTemperature, coordinate: CLLocationCoordinate2D(latitude: weather.coord.latiture, longitude: weather.coord.longitude))
            listWeatherMap.append(weatherMap)
        }
        
        self.presenter?.showMap(weathers: listWeatherMap)
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
