import XCTest

class ProvaAvaliacaoUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
    }

    func testExample() {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tables.staticTexts["Heróis favoritos"].swipeUp()

        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.containing(.staticText, identifier: "Cris").buttons["icon heart filled"].tap()
        tablesQuery.buttons["icon heart unfilled"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    }
