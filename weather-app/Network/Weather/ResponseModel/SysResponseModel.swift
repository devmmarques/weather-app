import Foundation

struct SysResponseModel: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Float
    let sunset: Float
}
