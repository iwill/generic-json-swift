import XCTest
@testable import GenericJSON

class EditingTests: XCTestCase {

    func testArrayEditing() throws {
        var json = try JSON([1, 2, 3])
        json[1] = 5
        XCTAssertEqual(json[1], 5)
        json[2] = ["json": 0, "test": 1]
        XCTAssertEqual(json[2]?.test, 1)
    }

    func testObjectEditing() throws {
        var json = try JSON([
            "a": [1, 2],
            "b": ["A", true, 1],
            ])
        json["a"] = 0
        XCTAssertEqual(json.a, 0)
        json["b"] = nil
        XCTAssertFalse((json.objectValue?.keys.contains("b"))!)
        json["b"] = JSON.null
        XCTAssertEqual(json.b, .null)
    }

    func testDynamicMemberEditing() throws {
        var json = try JSON([
            "test": [
                "a": "A",
                "b": true,
                "c": 1],
            ])
        json.test?.b = false
        XCTAssertFalse(json.test!.b!.boolValue!)
        json.test?.d = [1,2,3]
        XCTAssertNotNil(json.test?.d?.arrayValue)
    }
}
