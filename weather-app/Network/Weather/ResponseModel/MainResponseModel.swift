import Foundation

struct MainResponseModel: Codable {
    let temp: Float
    let feelsLike: Float
    let tempMin: Float
    let tempMax: Float
    let pressure: Float
    let humidity: Float
}
