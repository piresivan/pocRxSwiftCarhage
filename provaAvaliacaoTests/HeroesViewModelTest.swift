import XCTest
import RxSwift
import RxTest
import RxBlocking
import RxRelay

@testable import provaAvaliacao

class HeroesViewModelTest: XCTestCase {

    var viewModel: HeroesViewModel!
        var scheduler: TestScheduler!
        var disposeBag: DisposeBag!

        fileprivate var service: MockHeroesService!

        override func setUp() {
            super.setUp()
            self.disposeBag = DisposeBag()
            self.service = MockHeroesService()
            self.viewModel = HeroesViewModel(service: service)
        }

        override func tearDown() {
            self.viewModel = nil
            self.service = nil
            super.tearDown()
        }

        func testFetchWithError() {

            var returnMessage = ""
            service.converter = nil
            self.viewModel.output.errorMessage
                .drive(onNext: { [weak self] errorMessage in
                    guard self != nil else { return }
                    returnMessage = errorMessage
                })
                .disposed(by: disposeBag)

            XCTAssertNotNil(returnMessage)
        }

        func testFetchWithRecents() {

            service.converter = nil

            var object: [ResponseModel] = [ResponseModel]()
            service.fetchHeroes()
                .compactMap({$0.recents})
                .bind { (result) in
                    object = result
            }.dispose()

            XCTAssertNotNil(object)
        }

        func testFetchWithFavorites() {

            service.converter = nil

            var object: [ResponseModel] = [ResponseModel]()
            service.fetchHeroes()
                .compactMap({$0.favorites})
                .bind { (result) in
                    object = result
            }.dispose()

            XCTAssertNotNil(object)
        }
    }

    private class MockHeroesService: HeroServiceProtocol, HeroServiceObservable {

        var converter: Heroes?

        func fetchHeroes(_ completion: @escaping ((Result<Heroes, StatusResult>) -> Void)) {

            if let converter = converter {
                completion(Result.success(converter))
            } else {
                completion(Result.failure(StatusResult.custom(string: "No converter")))
            }
        }

        func fetchHeroes() -> Observable<Heroes> {
            if let converter = converter {
                return Observable.just(converter)
            } else {
                return Observable.error(StatusResult.custom(string: "No converter"))
            }
        }
    }
