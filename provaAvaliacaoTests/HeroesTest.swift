import XCTest
@testable import provaAvaliacao

class CurrencyTests: XCTestCase {

    func testParseEmptyCurrency() {

        let data = Data()
        let completion: ((Result<Heroes, StatusResult>) -> Void) = { result in
            switch result {
            case .success(let value):
                XCTAssertNotNil(value)
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }

        ParserHelper.parse(data: data, completion: completion)
    }

    func testParseCurrency() {
        guard let data = FileManager.readJson(forResource: "sample") else {
            XCTAssert(false, "Can't get data from sample.json")
            return
        }

        let completion: ((Result<Heroes, StatusResult>) -> Void) = { result in
            switch result {
            case .failure(let value):
                XCTAssertNotNil(value)
                XCTAssert(false, "Expected valid converter")
            case .success(let converter):
                XCTAssertEqual(converter.favorites[0].addressNeighborhood, "Vila Gomes Cardim")
                XCTAssertEqual(converter.favorites[0].firstName, "Cris")
                XCTAssertEqual(converter.favorites.count, 3, "Expected 3")
            }
        }

        ParserHelper.parse(data: data, completion: completion)
    }

    func testWrongKeyCurrency() {

        let dictionary = ["test": 123 as AnyObject]
        let result = Heroes.parseObject(dictionary: dictionary)

        switch result {
        case .success(let value):
            XCTAssertNotNil(value)
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }
}
