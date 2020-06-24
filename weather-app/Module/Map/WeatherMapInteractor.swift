import UIKit
import MapKit

final class WeatherMapInteractor: WeatherMapInputInteractorProtocol {
    
    var presenter: WeatherMapOutPutInteractorProtocol?
    
    var weathers: [Weather]
    
    init(weathers: [Weather]) {
        self.weathers = weathers
    }
    
    func fetchWeathers() {
        var listWeatherMap: [WeatherMap] = []
        
        for weather in weathers {
            let weatherMap = WeatherMap(title: weather.name, locationName: weather.name, temp: weather.main.temp, coordinate: CLLocationCoordinate2D(latitude: weather.coord.latiture, longitude: weather.coord.longitude))
            listWeatherMap.append(weatherMap)
        }
        
        self.presenter?.showMap(weathers: listWeatherMap)
    }
}
