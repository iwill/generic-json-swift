import XCTest

extension CodingTests {
    static let __allTests = [
        ("testDebugDescriptions", testDebugDescriptions),
        ("testDecoding", testDecoding),
        ("testDecodingBool", testDecodingBool),
        ("testEmptyCollectionDecoding", testEmptyCollectionDecoding),
        ("testEncoding", testEncoding),
        ("testFragmentEncoding", testFragmentEncoding),
    ]
}

extension EqualityTests {
    static let __allTests = [
        ("testEquality", testEquality),
    ]
}

extension InitializationTests {
    static let __allTests = [
        ("testInitialization", testInitialization),
        ("testInitializationFromCodable", testInitializationFromCodable),
        ("testUnknownTypeInitialization", testUnknownTypeInitialization),
    ]
}

extension QueryingTests {
    static let __allTests = [
        ("testArraySubscripting", testArraySubscripting),
        ("testArrayValue", testArrayValue),
        ("testBoolValue", testBoolValue),
        ("testFloatValue", testFloatValue),
        ("testNullValue", testNullValue),
        ("testObjectValue", testObjectValue),
        ("testStringSubscripting", testStringSubscripting),
        ("testStringSubscriptingSugar", testStringSubscriptingSugar),
        ("testStringValue", testStringValue),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CodingTests.__allTests),
        testCase(EqualityTests.__allTests),
        testCase(InitializationTests.__allTests),
        testCase(QueryingTests.__allTests),
    ]
}
#endif
