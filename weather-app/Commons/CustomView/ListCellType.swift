import Foundation

enum ListCellType<T> {
    case loading
    case cell(T)
    case error(WebserviceError)
}

