import XCTest
import GenericJSON

class MergingTests: XCTestCase {

    func testMerging() {
        let old: JSON = ["x": "y"]
        XCTAssertEqual(old.merging(with: [:]), old) // no change
        XCTAssertEqual(old.merging(with: ["a": "b"]), ["x": "y", "a": "b"]) // create
        XCTAssertEqual(old.merging(with: ["x": 1]), ["x": 1]) // update
        XCTAssertEqual(old.merging(with: ["x": nil]), ["x": nil]) // “delete”
    }

    func testMergingPrimitives() {
        XCTAssertEqual(JSON.number(2).merging(with: "foo"), "foo")
    }
}
