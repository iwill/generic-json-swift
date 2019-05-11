import Foundation

public extension JSON {

    /// Return the string value if this is a `.string`, otherwise `nil`
    var stringValue: String? {
        if case .string(let value) = self {
            return value
        }
        return nil
    }

    /// Return the double value if this is a `.number`, otherwise `nil`
    var doubleValue: Double? {
        if case .number(let value) = self {
            return value
        }
        return nil
    }

    /// Return the bool value if this is a `.bool`, otherwise `nil`
    var boolValue: Bool? {
        if case .bool(let value) = self {
            return value
        }
        return nil
    }

    /// Return the object value if this is an `.object`, otherwise `nil`
    var objectValue: [String: JSON]? {
        if case .object(let value) = self {
            return value
        }
        return nil
    }

    /// Return the array value if this is an `.array`, otherwise `nil`
    var arrayValue: [JSON]? {
        if case .array(let value) = self {
            return value
        }
        return nil
    }

    /// Return `true` iff this is `.null`
    var isNull: Bool {
        if case .null = self {
            return true
        }
        return false
    }
}
