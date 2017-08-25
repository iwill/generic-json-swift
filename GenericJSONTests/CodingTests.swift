import XCTest
@testable import GenericJSON

class CodingTests: XCTestCase {
    
    func testEncoding() throws {
        let json1: JSON = [
            "num": 1,
            "str": "baz",
            "bool": true,
            "null": nil,
            "array": [],
            "obj": [:],
        ]
        let encoded = try JSONEncoder().encode(json1)
        let str = String(data: encoded, encoding: .utf8)!
        XCTAssertEqual(str, """
            {"array":[],"num":1,"bool":true,"obj":{},"null":null,"str":"baz"}
            """)
    }

    func testFragmentEncoding() {
        let fragments: [JSON] = ["foo", 1, true, nil]
        for f in fragments {
            XCTAssertThrowsError(try JSONEncoder().encode(f))
        }
    }

    func testDecoding() throws {
        let input = """
            {"array":[1],"num":1,"bool":true,"obj":{},"null":null,"str":"baz"}
            """
        let json = try! JSONDecoder().decode(JSON.self, from: input.data(using: .utf8)!)
        XCTAssertEqual(json, [
            "num": 1,
            "str": "baz",
            "bool": true,
            "null": nil,
            "array": [1],
            "obj": [:],
        ])
    }

    func testDecodingBool() throws {
        XCTAssertEqual(try JSONDecoder().decode(JSON.self, from: "{\"b\":true}".data(using: .utf8)!), ["b":true])
        XCTAssertEqual(try JSONDecoder().decode(JSON.self, from: "{\"n\":1}".data(using: .utf8)!), ["n":1])
    }

    func testEmptyCollectionDecoding() throws {
        XCTAssertEqual(try JSONDecoder().decode(JSON.self, from: "[]".data(using: .utf8)!), [])
        XCTAssertEqual(try JSONDecoder().decode(JSON.self, from: "{}".data(using: .utf8)!), [:])
    }

    func testDebugDescriptions() {
        let fragments: [JSON] = ["foo", 1, true, nil]
        let descriptions = fragments.map { $0.debugDescription }
        XCTAssertEqual(descriptions, ["\"foo\"", "1.0", "true", "null"])
    }
}
