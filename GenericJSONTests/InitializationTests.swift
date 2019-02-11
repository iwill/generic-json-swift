import XCTest
@testable import GenericJSON

class InitializationTests: XCTestCase {
    
    func testInitialization() throws {
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
