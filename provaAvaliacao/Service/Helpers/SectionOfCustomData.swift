import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct SectionOfCustomData {
  var header: String
  var items: [ResponseModel]
}

extension SectionOfCustomData: SectionModelType {
  typealias Item = ResponseModel

   init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}
