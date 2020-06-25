import Foundation

enum StatusResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)

    var localizedDescription: String {
        switch self {
        case .network(let value):   return value
        case .parser(let value):    return value
        case .custom(let value):    return value
        }
    }
}
