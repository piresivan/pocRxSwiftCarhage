import Foundation
import RxSwift

protocol Parceable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, StatusResult>
}

final class ParserHelper {

    static func parse<T: Parceable>(data: Data, completion: (Result<T, StatusResult>) -> Void) {

        do {

            if let dictionary = try JSONSerialization.jsonObject(with: data,
                                                                 options: .allowFragments) as? [String: AnyObject] {
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let newModel):
                    completion(.success(newModel))
                }
            } else {
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}

extension ParserHelper {

    static func parse<T: Parceable>(data: Data) -> Observable<T> {

        do {

            if let dictionary = try JSONSerialization.jsonObject(with: data,
                                                                 options: .allowFragments) as? [String: AnyObject] {
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    return Observable.error(error)
                case .success(let newModel):
                    return Observable.just(newModel)
                }
            } else {
                return Observable.error(StatusResult.parser(string: "Json data is not an array"))
            }
        } catch {
            return Observable.error(StatusResult.parser(string: "Error while parsing json data"))
        }
    }
}
