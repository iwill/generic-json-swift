import XCTest
import GenericJSON

class MutationTests: XCTestCase {}

// MARK: Array Subscripting
extension MutationTests {

    func testArraySubscriptBasicCase() {
        var json: JSON = [1, 2]
        json[1] = 3
        XCTAssertEqual(json, [1, 3])
    }

    func testArraySubscriptInvalidIndexes() {
        var json: JSON = [1, 2]
        json[5] = 4
        XCTAssertEqual(json, [1, 2])
        json[-1] = 4
        XCTAssertEqual(json, [1, 2])
    }

    func testArraySubscriptValueConversion() {
        var json: JSON = true
        json[0] = 1
        XCTAssertEqual(json, [])
    }

    func testArraySubscriptNilWriting() {
        var json: JSON = [true]
        let empty: JSON? = nil
        json[0] = empty
        XCTAssertEqual(json, [.null])
    }
}

// MARK: Key Subscripting
extension MutationTests {

    func testKeySubscriptBasicCase() {
        var json: JSON = ["foo": true]
        json.foo = false
        XCTAssertEqual(json, ["foo": false])
    }

    func testKeySubscriptDeleting() {
        var json: JSON = ["foo": true]
        json.foo = nil
        XCTAssertEqual(json, [:])
    }

    func testKeySubscriptCreating() {
        var json: JSON = [:]
        json.foo = true
        XCTAssertEqual(json, ["foo": true])
    }

    func testKeySubscriptValueConversion() {
        var json: JSON = true
        json.foo = true
        XCTAssertEqual(json, ["foo": true])
    }
}
