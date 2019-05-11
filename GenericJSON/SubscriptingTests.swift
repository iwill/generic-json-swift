import XCTest
import GenericJSON

class SubscriptingTests: XCTestCase {

    func testKeyPath() {
        let json: JSON = [
            "string": "foo bar",
            "boolean": true,
            "number": 123,
            "object": [
                "str": "col",
                "arr": [1, 2, 3],
                "obj": [
                    "x": "rah",
                    "y": "tar",
                    "z": "yaz"
                ]
            ]
        ]
        XCTAssertEqual(json[keyPath: "string"], "foo bar")
        XCTAssertEqual(json[keyPath: "boolean"], true)
        XCTAssertEqual(json[keyPath: "number"], 123)
        XCTAssertEqual(json[keyPath: "object.str"], "col")
        XCTAssertEqual(json[keyPath: "object.arr"], [1, 2, 3])
        XCTAssertEqual(json[keyPath: "object.obj.y"], "tar")
    }
}

// MARK: Array Subscripting
extension SubscriptingTests {

    func testArraySubscriptReading() {
        let json: JSON = ["foo", "bar"]
        XCTAssertEqual(json[0], "foo")
        XCTAssertEqual(json[-1], nil)
        XCTAssertEqual(json[2], nil)
        XCTAssertEqual(json["foo"], nil)
    }

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
extension SubscriptingTests {

    func testKeySubscriptReading() {
        let json: JSON = ["foo": "bar"]
        XCTAssertEqual(json["foo"], "bar")
        XCTAssertEqual(json[0], nil)
        XCTAssertEqual(json["nonesuch"], nil)
    }

    func testKeySubscriptSugar() {
        let json: JSON = ["foo": "bar"]
        XCTAssertEqual(json.foo, "bar")
        XCTAssertEqual(json.nonesuch, nil)
    }

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
