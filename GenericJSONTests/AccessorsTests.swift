import XCTest
import GenericJSON

class AccessorsTests: XCTestCase {
    
    // MARK: - String Accessors

    func testStringValueGetter() {
        XCTAssertEqual(JSON.string("foo").stringValue, "foo")
        XCTAssertEqual(JSON.number(42).stringValue, nil)
        XCTAssertEqual(JSON.null.stringValue, nil)
    }
    
    func testStringValueSetter() {
        var json = JSON.string("foo")
        json.stringValue = "bar"
        XCTAssertEqual(json.stringValue, "bar")
        json.stringValue = nil
        XCTAssertNil(json.stringValue)
    }
    
    // MARK: - Float Accessors

    func testFloatValueGetter() {
        XCTAssertEqual(JSON.number(42).floatValue, 42)
        XCTAssertEqual(JSON.string("foo").floatValue, nil)
        XCTAssertEqual(JSON.null.floatValue, nil)
    }
    
    func testFloatValueSetter() {
        var json = JSON.number(42)
        json.floatValue = 101
        XCTAssertEqual(json.floatValue, 101)
        json.floatValue = nil
        XCTAssertNil(json.floatValue)
    }
    
    // MARK: - Boolean Accessors

    func testBoolValueGetter() {
        XCTAssertEqual(JSON.bool(true).boolValue, true)
        XCTAssertEqual(JSON.string("foo").boolValue, nil)
        XCTAssertEqual(JSON.null.boolValue, nil)
    }
    
    func testBoolValueSetter() {
        var json = JSON.bool(true)
        json.boolValue = false
        XCTAssertEqual(json.boolValue, false)
        json.boolValue = nil
        XCTAssertNil(json.boolValue)
    }
    
    // MARK: - Object Accessors

    func testObjectValueGetter() {
        XCTAssertEqual(JSON.object(["foo": "bar"]).objectValue, ["foo": JSON.string("bar")])
        XCTAssertEqual(JSON.string("foo").objectValue, nil)
        XCTAssertEqual(JSON.null.objectValue, nil)
    }
    
    func testObjectValueSetter() {
        var json = JSON.object(["foo": "bar"])
        let newJSON = JSON.object(["zap": "roo"])
        json.objectValue = newJSON.objectValue
        XCTAssertEqual(json, newJSON)
        json.objectValue = nil
        XCTAssertNil(json.objectValue)
    }
    
    // MARK: - Array Accessors

    func testArrayValueGetter() {
        XCTAssertEqual(JSON.array(["foo", "bar"]).arrayValue, [JSON.string("foo"), JSON.string("bar")])
        XCTAssertEqual(JSON.string("foo").arrayValue, nil)
        XCTAssertEqual(JSON.null.arrayValue, nil)
    }
    
    func testArrayValueSetter() {
        var json = JSON.array(["foo", "bar"])
        let newJSON = JSON.array(["zap", "roo", "dip"])
        json.arrayValue = newJSON.arrayValue
        XCTAssertEqual(json, newJSON)
        json.arrayValue = nil
        XCTAssertNil(json.arrayValue)
    }
    
    // MARK: Null

    func testNullValue() {
        XCTAssertEqual(JSON.null.isNull, true)
        XCTAssertEqual(JSON.string("foo").isNull, false)
    }

    // MARK: Int Subscript

    func testArraySubscriptGetter() {
        let json: JSON = ["foo", "bar"]
        XCTAssertEqual(json[0], JSON.string("foo"))
        XCTAssertEqual(json[-1], nil) // out of bounds - getter returns nil
        XCTAssertEqual(json[2], nil)  // out of bounds - getter returns nil
        XCTAssertEqual(json["foo"], nil)
    }
    
    func testArraySubscriptSetter() {
        var json: JSON = ["foo", "bar"]
        json[1] = JSON.string("zap")
        XCTAssertEqual(json, try! JSON.init(["foo", "zap"]))
        json[-1] = JSON.string("zap") // out of bounds - setter performs no operation
        XCTAssertEqual(json, try! JSON.init(["foo", "zap"]))
        json[2] = JSON.string("zap") // out of bounds - setter performs no operation
        XCTAssertEqual(json, try! JSON.init(["foo", "zap"]))
        json[1] = nil
        XCTAssertNil(json[1])
    }

    // MARK: String Subscript
    
    func testStringSubscriptGetter() {
        let json: JSON = ["foo": "bar"]
        XCTAssertEqual(json["foo"], JSON.string("bar"))
        XCTAssertEqual(json[0], nil)
        XCTAssertEqual(json["nonesuch"], nil)
    }
    
    func testStringSubscriptSetter() {
        var json: JSON = ["foo": "bar"]
        json["foo"] = JSON.string("zap")
        XCTAssertEqual(json, try! JSON.init(["foo": "zap"]))
        json["foo"] = nil
        XCTAssertNil(json["foo"])
    }
    
}
