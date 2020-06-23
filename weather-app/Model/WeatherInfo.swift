import Foundation

struct WeatherInfo {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    init(response: WeatherInfoResponseModel) {
        self.id = response.id
        self.main = response.main
        self.description = response.description
        self.icon = response.icon
    }
}
