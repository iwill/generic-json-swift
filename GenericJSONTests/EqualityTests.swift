import XCTest
@testable import GenericJSON

class EqualityTests: XCTestCase {

    func testEquality() {
        XCTAssertEqual([] as JSON, [] as JSON)
        XCTAssertEqual(nil as JSON, nil as JSON)
        XCTAssertEqual(1 as JSON, 1 as JSON)
        XCTAssertEqual(1 as JSON, 1.0 as JSON)
        XCTAssertEqual("foo" as JSON, "foo" as JSON)
        XCTAssertEqual(["foo": ["bar"]] as JSON, ["foo": ["bar"]] as JSON)
    }
}
