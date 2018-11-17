// Credit: Ole Begemann - https://oleb.net/blog/2017/01/dictionary-key-paths/

import Foundation

/// Struct that models a key path as an array of segments.
public struct KeyPath {
    public private(set) var segments: [String]
    
    public var isEmpty: Bool { return segments.isEmpty }
    public var path: String {
        return segments.joined(separator: ".")
    }
    
    /// Strips off the first segment and returns a pair consisting of the first segment and the remaining key path.
    /// Returns `nil` if the key path has no segments.
    public func headAndTail() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail = segments
        let head = tail.removeFirst()
        return (head, KeyPath(segments: tail))
    }
    
}

/// Initializes a KeyPath with a string of the form "this.is.a.keypath"
extension KeyPath {
    public init(_ string: String) {
        segments = string.components(separatedBy: ".")
    }
}

extension KeyPath: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}
