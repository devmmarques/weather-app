enum EmptyState {
  case weather
  case location
  
  var title: String {
    switch self {
    case .weather:
        return L10n.emptyStateTitleWeather
    case .location:
        return L10n.emptyStateTitleLocation
    }
  }

  var description: String {
    switch self {
    case .weather:
        return L10n.emptyStateDescriptionWeather
    case .location:
        return L10n.emptyStateDescriptionLocation
    }
  }
}
