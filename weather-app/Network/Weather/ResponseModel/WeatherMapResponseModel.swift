import Foundation

struct WeatherMapResponseModel: Codable {
    
    let id: Float
    let name: String
    let cod: Int
    let dt: Float
    let coord: CoordinatesResponseModel
    let weather: [WeatherResponseModel]
    let main: MainResponseModel
    let sys: SysResponseModel
}
