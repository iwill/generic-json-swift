import XCTest
import GenericJSON

class QueryingTests: XCTestCase {

    func testStringValue() {
        XCTAssertEqual(JSON.string("foo").stringValue, "foo")
        XCTAssertEqual(JSON.number(42).stringValue, nil)
        XCTAssertEqual(JSON.null.stringValue, nil)
    }

    func testFloatValue() {
        XCTAssertEqual(JSON.number(42).doubleValue, 42)
        XCTAssertEqual(JSON.string("foo").doubleValue, nil)
        XCTAssertEqual(JSON.null.doubleValue, nil)
    }

    func testBoolValue() {
        XCTAssertEqual(JSON.bool(true).boolValue, true)
        XCTAssertEqual(JSON.string("foo").boolValue, nil)
        XCTAssertEqual(JSON.null.boolValue, nil)
    }

    func testObjectValue() {
        XCTAssertEqual(JSON.object(["foo": "bar"]).objectValue, ["foo": JSON.string("bar")])
        XCTAssertEqual(JSON.string("foo").objectValue, nil)
        XCTAssertEqual(JSON.null.objectValue, nil)
    }

    func testArrayValue() {
        XCTAssertEqual(JSON.array(["foo", "bar"]).arrayValue, [JSON.string("foo"), JSON.string("bar")])
        XCTAssertEqual(JSON.string("foo").arrayValue, nil)
        XCTAssertEqual(JSON.null.arrayValue, nil)
    }

    func testNullValue() {
        XCTAssertEqual(JSON.null.isNull, true)
        XCTAssertEqual(JSON.string("foo").isNull, false)
    }
}
