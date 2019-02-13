import XCTest
@testable import GenericJSON

class InitializationTests: XCTestCase {

    func testLiteralInitialization() {
        XCTAssertEqual(nil as JSON, .null)
        XCTAssertEqual(true as JSON, .bool(true))
        XCTAssertEqual([1, 2] as JSON, .array([.number(1), .number(2)]))
        XCTAssertEqual(["x": 1] as JSON, .object(["x": .number(1)]))
        XCTAssertEqual(1.25 as JSON, .number(1.25))
        XCTAssertEqual("foo" as JSON, .string("foo"))
    }

    func testValueInitialization() throws {
        let num = 1
        let bool = true
        let str = "foo"
        let json = try JSON([
            "a": [num, bool],
            "b": [str, [str], [str: bool]],
        ])
        XCTAssertEqual(json, [
            "a": [1, true],
            "b": ["foo", ["foo"], ["foo": true]],
        ])
    }

    func testUnknownTypeInitialization() {
        XCTAssertThrowsError(try JSON(["foo": Date()]))
    }

    func testNilInitializationFromAny() throws {
        XCTAssertEqual(try JSON(Optional<Int>.none as Any), .null)
        XCTAssertEqual(try JSON(Optional<Date>.none as Any), .null)
        XCTAssertThrowsError(try JSON(Optional<Date>.some(Date()) as Any))
    }

    func testNSNullInitialization() throws {
        XCTAssertEqual(try JSON(NSNull()), .null)
    }

    func testInitializationFromCodable() throws {

        struct Foo: Codable {
            let a: String = "foo"
            let b: Bool = true
        }

        let json = try JSON(encodable: Foo())
        XCTAssertEqual(json, [
            "a": "foo",
            "b": true,
        ])
    }
}
