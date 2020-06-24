struct Coordinates {
    let latiture: Double
    let longitude: Double
    
    init(response: CoordinatesResponseModel) {
        self.latiture = response.lat
        self.longitude = response.lon
    }
}
