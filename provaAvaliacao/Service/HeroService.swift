import Foundation
import RxSwift

protocol HeroServiceProtocol: class {
    func fetchHeroes(_ completion: @escaping ((Result<Heroes, StatusResult>) -> Void))
}

protocol HeroServiceObservable: class {
    func fetchHeroes() -> Observable<Heroes>
}
