import XCTest
import GenericJSON

class QueryingTests: XCTestCase {

    func testStringValue() {
        XCTAssertEqual(JSON.string("foo").stringValue, "foo")
        XCTAssertEqual(JSON.number(42).stringValue, nil)
        XCTAssertEqual(JSON.null.stringValue, nil)
    }

    func testFloatValue() {
        XCTAssertEqual(JSON.number(42).floatValue, 42)
        XCTAssertEqual(JSON.string("foo").floatValue, nil)
        XCTAssertEqual(JSON.null.floatValue, nil)
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

    func testArraySubscripting() {
        let json: JSON = ["foo", "bar"]
        XCTAssertEqual(json[0], JSON.string("foo"))
        XCTAssertEqual(json[-1], nil)
        XCTAssertEqual(json[2], nil)
        XCTAssertEqual(json["foo"], nil)
    }

    func testStringSubscripting() {
        let json: JSON = ["foo": "bar"]
        XCTAssertEqual(json["foo"], JSON.string("bar"))
        XCTAssertEqual(json[0], nil)
        XCTAssertEqual(json["nonesuch"], nil)
    }

    func testStringSubscriptingSugar() {
        let json: JSON = ["foo": "bar"]
        XCTAssertEqual(json.foo, JSON.string("bar"))
        XCTAssertEqual(json.nonesuch, nil)
    }
    
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
        XCTAssertEqual(json[keyPath: KeyPath("string")], JSON.string("foo bar"))
        XCTAssertEqual(json[keyPath: KeyPath("boolean")], JSON.bool(true))
        XCTAssertEqual(json[keyPath: KeyPath("number")], JSON.number(123))
        XCTAssertEqual(json[keyPath: KeyPath("object.str")], JSON.string("col"))
        XCTAssertEqual(json[keyPath: KeyPath("object.arr")], JSON.array([1, 2, 3]))
        XCTAssertEqual(json[keyPath: KeyPath("object.obj.y")], JSON.string("tar"))
    }
}
