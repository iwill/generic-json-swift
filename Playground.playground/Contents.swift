import Cocoa
import GenericJSON

let json: JSON = [
    "foo": "bar",
    "bar": 1,
    "empty": nil,
]

let str = try String(data: try JSONEncoder().encode(json), encoding: .utf8)!

// MARK: - Key Path

struct KeyPath {
    private(set) var segments: [String]
    
    var isEmpty: Bool { return segments.isEmpty }
    var path: String {
        return segments.joined(separator: ".")
    }
    
    /// Strips off the first segment and returns a pair consisting of the first segment and the remaining key path.
    /// Returns `nil` if the key path has no segments.
    func headAndTail() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail = segments
        let head = tail.removeFirst()
        return (head, KeyPath(segments: tail))
    }
    
}

/// Initializes a KeyPath with a string of the form "this.is.a.keypath"
extension KeyPath {
    init(_ string: String) {
        segments = string.components(separatedBy: ".")
    }
}

extension KeyPath: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(value)
    }
    init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

// MARK: - Dictionary Keypath

extension Dictionary where Key == String {
    subscript(keyPath keyPath: KeyPath) -> Any? {
        get {
            switch keyPath.headAndTail() {
            case nil:
                // key path is empty.
                return nil
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                // Reached the end of the key path.
                let key = Key(stringLiteral: head)
                return self[key]
            case let (head, remainingKeyPath)?:
                // Key path has a tail we need to traverse.
                let key = Key(stringLiteral: head)
                switch self[key] {
                case let nestedDict as [Key: Any]:
                    // Next nest level is a dictionary.
                    // Start over with remaining key path.
                    return nestedDict[keyPath: remainingKeyPath]
                default:
                    // Next nest level isn't a dictionary.
                    // Invalid key path, abort.
                    return nil
                }
            }
        }
    }
}

let dict: [String : Any] = [
    "a" : "x",
    "b" : [
        "c" : "y",
        "d" : "z"
    ]
]

let keyPath = KeyPath("a")
let keyPath2 = KeyPath("s.b.c")
let keyPath3 = keyPath2.headAndTail()!.tail

dict[keyPath: keyPath]
dict[keyPath: keyPath3]

// MARK: - JSON key path

extension JSON {
    
    subscript(keyPath keyPath: KeyPath) -> JSON? {
        get {
            switch keyPath.headAndTail() {
            case nil:
                // key path is empty
                return nil
            case let (head, tail)? where tail.isEmpty:
                // reached end of key path
                let key = Key(stringLiteral: head)
                return self[key]
            case let (head, tail)?:
                // key path has tail we need to traverse
                let key = Key(stringLiteral: head)
                
                if let json = self[key] {
                    return json[keyPath: tail]
                } else {
                    return nil
                }
                
            }
        }
    }
    
}



let a = [1, 2, 3]
let b = a.dropFirst()

print(a)
print(b)
