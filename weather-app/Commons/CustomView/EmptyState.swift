enum EmptyState {
  case weather
  
  var title: String {
    return "Sem Previsão"
  }

  var description: String {
    return "Não foi possível encontrar a previsão do tempo para sua região."
  }

}
