import Foundation
import RxSwift
import RxCocoa

struct HeroesViewModel {

    weak var service: HeroServiceObservable?

     let input: Input
     let output: Output

     struct Input {
         let reload: PublishRelay<Void>
     }

     struct Output {
        let recents: [ResponseModel]
        let favorites: [ResponseModel]
        let errorMessage: Driver<String>
     }

     init(service: HeroServiceObservable = FileDataService.shared) {
        self.service = service

        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Void>()

        var objectRecents: [ResponseModel] = [ResponseModel]()
        service.fetchHeroes()
            .compactMap({$0.recents})
            .bind { (result) in
                objectRecents = result
        }.dispose()

        var objectFavorites: [ResponseModel] = [ResponseModel]()
        service.fetchHeroes()
            .compactMap({$0.favorites})
            .bind { (result) in
                objectFavorites = result
        }.dispose()

        self.input = Input(reload: reloadRelay)
        self.output = Output( recents: objectRecents,
                              favorites: objectFavorites,
                              errorMessage: errorRelay.asDriver(onErrorJustReturn: "An error happened"))
     }

}
