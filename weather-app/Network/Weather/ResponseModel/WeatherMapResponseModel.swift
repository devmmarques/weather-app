import Foundation

struct WeatherMapResponseModel: Codable {
    
    let message: String
    let cod: String
    let count: Int
    let list: [WeatherResponseModel]
    
}
