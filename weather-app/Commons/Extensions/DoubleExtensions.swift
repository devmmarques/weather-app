import Foundation

extension Double {
    
    func convertTemp(from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
      let mf = MeasurementFormatter()
      mf.numberFormatter.maximumFractionDigits = 0
      mf.unitOptions = .providedUnit
      let input = Measurement(value: self, unit: inputTempType)
      let output = input.converted(to: outputTempType)
      return mf.string(from: output)
    }
    
    func convertTemp(to outputTempType: UnitTemperature) -> String {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        var unit = outputTempType
        if outputTempType == .celsius {
            unit = .fahrenheit
        }
        let input = Measurement(value: self, unit: unit)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
    }
}
