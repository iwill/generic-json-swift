import XCTest
import GenericJSON

class QueryingTests: XCTestCase {

    func testGetStringValue() {
        XCTAssertEqual(JSON.string("foo").stringValue, "foo")
        XCTAssertEqual(JSON.number(42).stringValue, nil)
        XCTAssertEqual(JSON.null.stringValue, nil)
    }

    func testSetStringValue() {
        var value: JSON = "foo"
        value = "bar"
        XCTAssertEqual(value.stringValue, "bar")
    }

    func testGetFloatValue() {
        XCTAssertEqual(JSON.number(42).doubleValue, 42)
        XCTAssertEqual(JSON.string("foo").doubleValue, nil)
        XCTAssertEqual(JSON.null.doubleValue, nil)
    }

    func testSetFloatValue() {
        var value: JSON = 42
        value = 43
        XCTAssertEqual(value.doubleValue, 43)
    }

    func testGetBoolValue() {
        XCTAssertEqual(JSON.bool(true).boolValue, true)
        XCTAssertEqual(JSON.string("foo").boolValue, nil)
        XCTAssertEqual(JSON.null.boolValue, nil)
    }

    func testSetBoolValue() {
        var value: JSON = true
        value = false
        XCTAssertEqual(value, false)
    }

    func testGetObjectValue() {
        XCTAssertEqual(JSON.object(["foo": "bar"]).objectValue, ["foo": JSON.string("bar")])
        XCTAssertEqual(JSON.string("foo").objectValue, nil)
        XCTAssertEqual(JSON.null.objectValue, nil)
    }

    func testSetObjectValue() {
        var value: JSON = ["foo": "bar"]
        value = ["foo": "baz"]
        value["new"] = 42
        XCTAssertEqual(value, ["foo": "baz", "new": JSON(42)])
    }

    func testGetArrayValue() {
        XCTAssertEqual(JSON.array(["foo", "bar"]).arrayValue, [JSON.string("foo"), JSON.string("bar")])
        XCTAssertEqual(JSON.string("foo").arrayValue, nil)
        XCTAssertEqual(JSON.null.arrayValue, nil)
    }

    func testSetArrayValue() {
        var value: JSON = ["foo", "bar"]
        value = ["baz"]
        XCTAssertEqual(value, ["baz"])
    }

    func testGetNullValue() {
        XCTAssertEqual(JSON.null.isNull, true)
        XCTAssertEqual(JSON.string("foo").isNull, false)
    }

    func testSetNullValue() {
        var value: JSON = "foo"
        value = nil
        XCTAssertEqual(value, JSON.null)
    }

    func testGetArraySubscripting() {
        let json: JSON = ["foo", "bar"]
        XCTAssertEqual(json[0], JSON.string("foo"))
        XCTAssertEqual(json[-1], nil)
        XCTAssertEqual(json[2], nil)
        XCTAssertEqual(json["foo"], nil)
    }

    func testSetArraySubscripting() {
        var value: JSON = ["foo", "bar"]
        value[1] = "baz"
        XCTAssertEqual(value, ["foo", "baz"])
    }

    func testGetStringSubscripting() {
        let json: JSON = ["foo": "bar"]
        XCTAssertEqual(json["foo"], JSON.string("bar"))
        XCTAssertEqual(json[0], nil)
        XCTAssertEqual(json["nonesuch"], nil)
    }

    func testSetStringSubscripting() {
        var json: JSON = ["foo": "bar"]
        json["foo"] = "baz"
        XCTAssertEqual(json, ["foo": "baz"])
    }

    func testSetStringSubscriptingNewValue() {
        var json: JSON = ["foo": "bar"]
        json["baz"] = 42
        XCTAssertEqual(json, ["foo": "bar", "baz": JSON(42)])
    }

    func testGetStringSubscriptingSugar() {
        let json: JSON = ["foo": "bar"]
        XCTAssertEqual(json.foo, JSON.string("bar"))
        XCTAssertEqual(json.nonesuch, nil)
    }

    func testSetStringSubscriptingSugar() {
        var json: JSON = ["foo": "bar"]
        json.foo = "baz"
        XCTAssertEqual(json, ["foo": "baz"])
    }

    func testSetStringSubscriptingSugarNewValue() {
        var json: JSON = ["foo": "bar"]
        json.baz = 42
        XCTAssertEqual(json, ["foo": "bar", "baz": JSON(42)])
    }
    
    func testGetKeyPath() {
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

    func testSetKeyPath() {
        var json: JSON = [
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

        json[keyPath: "boolean"] = false
        XCTAssertEqual(json["boolean"], false)

        json[keyPath: "string"] = "baz"
        XCTAssertEqual(json.string, "baz")

        json[keyPath: "number"] = 42
        XCTAssertEqual(json["number"], 42)

        json[keyPath: "object.str"] = "new"
        XCTAssertEqual(json["object"]?["str"], "new")

        json[keyPath: "object.arr"] = [42]
        XCTAssertEqual(json["object"]?["arr"], [42])

        json[keyPath: "object.obj.y"] = "new"
        XCTAssertEqual(json["object"]?["obj"]?["y"], "new")
    }

    func testSetKeyPathNewValue() {
        var json: JSON = [
            "object": [:]
        ]

        json[keyPath: "object.new.new"] = 42
        XCTAssertEqual(json["object"]?["new"]?["new"], 42)
    }
}
