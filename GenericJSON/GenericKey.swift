import Foundation

struct GenericKey {

    let val: String

    public init(_ val: String) {
        self.val = val
    }
}

extension GenericKey: CodingKey {

    public init?(stringValue: String) {
        val = stringValue
    }

    public var stringValue: String {
        return val
    }

    public init?(intValue: Int) {
        return nil
    }

    public var intValue: Int? {
        return nil
    }
}
