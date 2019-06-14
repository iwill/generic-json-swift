import Foundation

extension JSON {

    /// Merge current JSON value with another one
    ///
    /// If we call the current JSON value `old` and the incoming JSON value
    /// `new`, the precise merging rules are:
    ///
    /// 1. If `old` or `new` are anything but an object, set `old` to `new`.
    /// 2. If both `old` and `new` are objects, create a merged object like this:
    ///     1. Add keys from `old` not present in `new` (“no change” case).
    ///     2. Add keys from `new` not present in `old` (“create” case).
    ///     3. For keys present in both `old` and `new`, apply merge recursively to their values (“update” case).
    public mutating func merge(with new: JSON) {

        // If old or new are anything but an object, set old to new.
        guard case .object(let lhs) = self, case .object(let rhs) = new else {
            self = new
            return
        }

        var merged: [String: JSON] = [:]

        // Add keys from old not present in new (“no change” case).
        for (key, val) in lhs where rhs[key] == nil {
            merged[key] = val
        }

        // Add keys from new not present in old (“create” case).
        for (key, val) in rhs where lhs[key] == nil {
            merged[key] = val
        }

        // For keys present in both old and new, apply merge recursively to their values.
        for key in lhs.keys where rhs[key] != nil {
            merged[key] = lhs[key]?.merging(with: rhs[key]!)
        }

        self = .object(merged)
    }

    /// Return a new JSON value by merging two other ones
    ///
    /// This is a non-mutating version of `merge(with:)`.
    public func merging(with new: JSON) -> JSON {
        return with(copyOf: self) {
            $0.merge(with: new)
        }
    }
}

private func with<T>(copyOf item: T, update: (inout T) throws -> Void) rethrows -> T {
    var this = item
    try update(&this)
    return this
}
