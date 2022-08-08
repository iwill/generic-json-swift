import Foundation

public extension JSON {

    /// Return the string value if this is a `.string`, otherwise `nil`
    var stringValue: String? {
        get {
            if case .string(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self = .string(newValue)
            } else {
                self = .null
            }
        }
    }

    /// Return the double value if this is a `.number`, otherwise `nil`
    var doubleValue: Double? {
        get {
            if case .number(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self = .number(newValue)
            } else {
                self = .null
            }
        }
    }

    /// Return the bool value if this is a `.bool`, otherwise `nil`
    var boolValue: Bool? {
        get {
            if case .bool(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self = .bool(newValue)
            } else {
                self = .null
            }
        }
    }

    /// Return the object value if this is an `.object`, otherwise `nil`
    var objectValue: [String: JSON]? {
        get {
            if case .object(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self = .object(newValue)
            } else {
                self = .null
            }
        }
    }

    /// Return the array value if this is an `.array`, otherwise `nil`
    var arrayValue: [JSON]? {
        get {
            if case .array(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self = .array(newValue)
            } else {
                self = .null
            }
        }
    }

    /// Return `true` iff this is `.null`
    var isNull: Bool {
        if case .null = self {
            return true
        }
        return false
    }

    mutating func setToNull() {
        self = .null
    }

    /// If this is an `.array`, return item at index
    ///
    /// If this is not an `.array` or the index is out of bounds, returns `nil`.
    subscript(index: Int) -> JSON? {
        get {
            if case .array(let arr) = self, arr.indices.contains(index) {
                return arr[index]
            }
            return nil
        }
        set {
            guard case .array(var arr) = self else {
                fatalError("Subscript assignment of JSON value that is not an array")
            }

            arr[index] = newValue!
            self = .array(arr)
        }
    }

    /// If this is an `.object`, return item at key
    subscript(key: String) -> JSON? {
        get {
            if case .object(let dict) = self {
                return dict[key]
            }
            return nil
        }
        set {
            guard case .object(var dict) = self else {
                fatalError("Subscript assignment of JSON value that is not a dictionary")
            }

            dict[key] = newValue!
            self = .object(dict)
        }
    }

    /// Dynamic member lookup sugar for string subscripts
    ///
    /// This lets you write `json.foo` instead of `json["foo"]`.
    subscript(dynamicMember member: String) -> JSON? {
        get { self[member] }
        set { self[member] = newValue }
    }
    
    /// Return the JSON type at the keypath if this is an `.object`, otherwise `nil`
    ///
    /// This lets you write `json[keyPath: "foo.bar.jar"]`.
    subscript(keyPath keyPath: String) -> JSON? {
        get { queryKeyPath(keyPath.components(separatedBy: ".")) }
        set { updateKeyPath(keyPath.components(separatedBy: "."), &self, newValue!) }
    }
    
    func queryKeyPath<T>(_ path: T) -> JSON? where T: Collection, T.Element == String {
        
        // Only object values may be subscripted
        guard case .object(let object) = self else {
            return nil
        }
        
        // Is the path non-empty?
        guard let head = path.first else {
            return nil
        }
        
        // Do we have a value at the required key?
        guard let value = object[head] else {
            return nil
        }
        
        let tail = path.dropFirst()
        
        return tail.isEmpty ? value : value.queryKeyPath(tail)
    }

    func updateKeyPath<T>(_ path: T, _ json: inout JSON, _ newValue: JSON) where T: Collection, T.Element == String {
        // Only object values may be subscripted
        guard case .object = json else {
            fatalError("Keypath \(path) applied to non-object")
        }

        // Is the path non-empty?
        guard let head = path.first else {
            return
        }

        let tail = path.dropFirst()

        guard !tail.isEmpty else {
            json[head] = newValue
            return
        }

        if json[head] == nil {
            json[head] = [:]
        }

        updateKeyPath(tail, &json[head]!, newValue)
    }
}
