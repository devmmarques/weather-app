enum EmptyState {
  case weather
  
  var title: String {
    return L10n.emptyStateTitleWeather
  }

  var description: String {
    return L10n.emptyStateDescriptionWeather
  }

}
