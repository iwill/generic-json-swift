import Foundation

public extension JSON {
    
    /// Return the string value if this is a `.string`, otherwise `nil`.
    public var stringValue: String? {
        get {
            if case .string(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self = JSON(stringLiteral: newValue)
            } else {
                self = JSON.null
            }
        }
    }
    
    /// Return the float value if this is a `.number`, otherwise `nil`.
    public var floatValue: Float? {
        get {
            if case .number(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self = JSON(floatLiteral: newValue)
            } else {
                self = JSON.null
            }
        }
    }
    
    /// Return the bool value if this is a `.bool`, otherwise `nil`.
    public var boolValue: Bool? {
        get {
            if case .bool(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self = JSON(booleanLiteral: newValue)
            } else {
                self = JSON.null
            }
        }
    }
    
    /// Return the object value if this is an `.object`, otherwise `nil`.
    public var objectValue: [String: JSON]? {
        get {
            if case .object(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self = JSON.object(newValue)
            } else {
                self = JSON.null
            }
        }
    }
    
    /// Return the array value if this is an `.array`, otherwise `nil`.
    public var arrayValue: [JSON]? {
        get {
            if case .array(let value) = self {
                return value
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self =  JSON.array(newValue)
            } else {
                self = JSON.null
            }
        }
    }
    
    /// Return `true` iff this is `.null`.
    public var isNull: Bool {
        if case .null = self {
            return true
        }
        return false
    }
    
    /// If this is an `.array`, return item at index.
    ///
    /// If this is not an `.array` or the index is out of bounds, returns `nil`.
    public subscript(index: Int) -> JSON? {
        get {
            if case .array(let arr) = self, arr.indices.contains(index) {
                return arr[index]
            }
            return nil
        }
        set {
            if case .array(var arr) = self, arr.indices.contains(index) {
                if let newValue = newValue {
                    arr[index] = newValue // update value at index
                    
                    /*
                     SwiftyJSON uses a backing type and updates the value at the index rather than copying, updating,
                     and replacing the array.
                     https://github.com/SwiftyJSON/SwiftyJSON/blob/3f6f1d32df6e5f334593682b20bb829e48bffbee/Source/SwiftyJSON.swift#L413
                     
                     My method may be inefficient?
                     */
                    
                    self = JSON.array(arr)
                } else {
                    self = JSON.null
                }
            }
        }
    }
    
    /// If this is an `.object`, return item at key.
    public subscript(key: String) -> JSON? {
        get {
            if case .object(let dict) = self {
                return dict[key]
            }
            return nil
        }
        set {
            if case .object(var obj) = self {
                obj[key] = newValue
                self = JSON.object(obj)
            }
        }
    }
}
