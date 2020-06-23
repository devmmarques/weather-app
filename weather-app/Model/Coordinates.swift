struct Coordinates {
    let latiture: Float
    let longitude: Float
    
    init(response: CoordinatesResponseModel) {
        self.latiture = response.lat
        self.longitude = response.lon
    }
}
