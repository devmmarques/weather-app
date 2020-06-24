import Foundation

struct WeatherResponseModel: Codable {
    let id: Float
    let name: String
    let coord: CoordinatesResponseModel
    let main: MainResponseModel
    let dt: Float
    let wind: WindResponseModel
    let weather: [WeatherInfoResponseModel]
}
