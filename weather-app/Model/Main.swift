import Foundation

struct Main {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double
    
    init(response: MainResponseModel) {
        self.temp = response.temp
        self.feelsLike = response.feelsLike
        self.tempMin = response.tempMin
        self.tempMax = response.tempMax
        self.pressure = response.pressure
        self.humidity = response.humidity
    }
}
