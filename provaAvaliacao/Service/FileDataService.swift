import Foundation
import RxSwift

final class FileDataService: HeroServiceProtocol {

    static let shared = FileDataService()

    func fetchHeroes(_ completion: @escaping ((Result<Heroes, StatusResult>) -> Void)) {

        guard let data = FileManager.readJson(forResource: "sample") else {
            completion(Result.failure(StatusResult.custom(string: "No file or data")))
            return
        }

        ParserHelper.parse(data: data, completion: completion)
    }
}

extension FileDataService: HeroServiceObservable {

    func fetchHeroes() -> Observable<Heroes> {

        guard let data = FileManager.readJson(forResource: "sample") else {
            return Observable.error(StatusResult.custom(string: "No file or data"))
        }

        return ParserHelper.parse(data: data)
    }
}

extension FileManager {

    static func readJson(forResource fileName: String ) -> Data? {

        let bundle = Bundle(for: FileDataService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }

        return nil
    }
}
