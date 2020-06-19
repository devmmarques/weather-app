import Foundation

struct WeatherResponseModel: Codable {
    let id: Float
    let main: String
    let description: String
    let icon: String
}
