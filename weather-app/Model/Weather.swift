import Foundation

struct Weather {
    
    let id: Float
    let name: String
    let coord: Coordinates
    let main: Main
    let dt: Float
    let weather: [WeatherInfo]
    
    init(response: WeatherResponseModel) {
        self.id = response.id
        self.name = response.name
        self.coord = Coordinates(response: response.coord)
        self.main = Main(response: response.main)
        self.dt = response.dt
        self.weather = response.weather.map({ WeatherInfo(response: $0 )})
    }
}
