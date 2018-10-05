import Foundation

public extension JSON {

    /// Return the string value if this is a `.string`, otherwise `nil`
    public var stringValue: String? {
        if case .string(let value) = self {
            return value
        }
        return nil
    }

    /// Return the float value if this is a `.number`, otherwise `nil`
    public var floatValue: Float? {
        if case .number(let value) = self {
            return value
        }
        return nil
    }

    /// Return the bool value if this is a `.bool`, otherwise `nil`
    public var boolValue: Bool? {
        if case .bool(let value) = self {
            return value
        }
        return nil
    }

    /// Return the object value if this is an `.object`, otherwise `nil`
    public var objectValue: [String: JSON]? {
        if case .object(let value) = self {
            return value
        }
        return nil
    }

    /// Return the array value if this is an `.array`, otherwise `nil`
    public var arrayValue: [JSON]? {
        if case .array(let value) = self {
            return value
        }
        return nil
    }

    /// Return `true` iff this is `.null`
    public var isNull: Bool {
        if case .null = self {
            return true
        }
        return false
    }

    /// If this is an `.array`, return item at index
    ///
    /// If this is not an `.array` or the index is out of bounds, returns `nil`.
    public subscript(index: Int) -> JSON? {
        if case .array(let arr) = self, arr.indices.contains(index) {
            return arr[index]
        }
        return nil
    }

    /// If this is an `.object`, return item at key
    public subscript(key: String) -> JSON? {
        if case .object(let dict) = self {
            return dict[key]
        }
        return nil
    }

    /// Dynamic member lookup sugar for string subscripts
    ///
    /// This lets you write `json.foo` instead of `json["foo"]`.
    subscript(dynamicMember member: String) -> JSON? {
        return self[member]
    }
    
    /// Return the JSON type at the keypath if this is an `.object`, otherwise `nil`
    ///
    /// This lets you write `json["foo.bar.jar"]`.
    public func valueForKeyPath(_ keyPath: String) -> JSON? {
        
        guard case .object(let object) = self else {
            return nil
        }
        
        var keys = keyPath.components(separatedBy: ".")
        guard let key = keys.first else {
            return nil
        }
        
        guard let json = object[key] else {
            return nil
        }
        keys.remove(at: 0)
        
        // recurse on the json if of case objectValue
        if !keys.isEmpty,  let _ = json.objectValue {
            let rejoined = keys.joined(separator: ".")
            return json.valueForKeyPath(rejoined)
        }
        
        return json
        
    }
}
