import XCTest
@testable import GenericJSON

class InitializationTests: XCTestCase {

    func testLiteralInitialization() {
        XCTAssertEqual(nil as JSON, .null)
        XCTAssertEqual(true as JSON, .bool(true))
        XCTAssertEqual([1, 2] as JSON, .array([.number(1), .number(2)]))
        XCTAssertEqual(["x": 1] as JSON, .object(["x": .number(1)]))
        XCTAssertEqual(3.4028236e+38 as JSON, .number(3.4028236e+38))
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

    func testInitializationFromJSONSerilization() throws {

        let jsonData = """
            {
                "array": [
                    1,
                    2,
                    3
                ],
                "boolean": true,
                "null": null,
                "number": 1,
                "greatest_int": \(Int.max),
                "greatest_double": \(Double.greatestFiniteMagnitude),
                "object": {
                    "a": "b"
                },
                "string": "Hello World"
            }
            """.data(using: .utf8)!

        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
        let json = try JSON(jsonObject)

        XCTAssertEqual(json["array"]!, JSON.array([1, 2, 3]))
        XCTAssertEqual(json["boolean"]!, JSON.bool(true))
        XCTAssertEqual(json["number"]!, JSON.number(1))
        XCTAssertEqual(json["greatest_int"]!, JSON.number(Double(Int.max)))
        XCTAssertEqual(json["greatest_double"]!, JSON.number(Double.greatestFiniteMagnitude))
        XCTAssertEqual(json["null"]!, JSON.null)
        XCTAssertEqual(json["object"]!, JSON.object(["a": "b"]))
        XCTAssertEqual(json["string"]!, JSON.string("Hello World"))

    }

}
