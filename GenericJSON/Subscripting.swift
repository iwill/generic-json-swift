import Foundation

public extension JSON {

    /// Get or set item on given index in an array
    ///
    /// For out-of-bounds indexes, reading returns `nil` and writing does nothing.
    /// For non-array values, reading returns `nil` and writing converts the value
    /// into an empty array. When writing, `nil` values get converted to `JSON.null`.
    subscript(index: Int) -> JSON? {

        get {
            // Reading from a non-array value returns `nil`
            guard case .array(let arr) = self else { return nil }
            // Reading from an out-of-bounds index returns `nil`
            guard arr.indices.contains(index) else { return nil }
            // Regular access
            return arr[index]
        }

        set {
            // Writing to a non-array value converts the value into an empty array.
            // TODO: This is not really very helpful, can we do better?
            guard case .array(var arr) = self else {
                self = .array([])
                return
            }

            // Writing to an out-of-bounds index does nothing
            guard arr.indices.contains(index) else { return }

            // Regular access
            arr[index] = newValue ?? .null
            self = .array(arr)
        }
    }

    /// Get or set item under given key in an object
    ///
    /// For non-object values, reading returns `nil` and writing converts the value
    /// into an object containing just the key & value being set.
    subscript(key: String) -> JSON? {
        get {
            // Reading from a non-object value returns `nil`
            guard case .object(let dict) = self else { return nil }
            // Regular access
            return dict[key]
        }
        set {
            var dict = objectValue ?? [:]
            dict[key] = newValue
            self = .object(dict)
        }
    }

    /// Dynamic member lookup sugar for string subscripts
    ///
    /// This lets you write `json.foo` instead of `json["foo"]`.
    subscript(dynamicMember member: String) -> JSON? {
        get {
            return self[member]
        }
        set {
            self[member] = newValue
        }
    }

    /// Return the JSON type at the keypath if this is an `.object`, otherwise `nil`
    ///
    /// This lets you write `json[keyPath: "foo.bar.jar"]`.
    subscript(keyPath keyPath: String) -> JSON? {
        return queryKeyPath(keyPath.components(separatedBy: "."))
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
}
