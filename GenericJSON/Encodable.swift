import Foundation

extension JSON: Encodable {

    public func encode(to encoder: Encoder) throws {
        switch self {
            case .string(let str):
                var container = encoder.singleValueContainer()
                try container.encode(str)
            case .number(let num):
                var container = encoder.singleValueContainer()
                try container.encode(num)
            case .bool(let bool):
                var container = encoder.singleValueContainer()
                try container.encode(bool)
            case .null:
                var container = encoder.singleValueContainer()
                try container.encodeNil()
            case .array(let array):
                var container = encoder.unkeyedContainer()
                for item in array { try container.encode(item) }
            case .object(let obj):
                var container = encoder.container(keyedBy: GenericKey.self)
                for (key, val) in obj {
                    try container.encode(val, forKey: GenericKey(key))
                }
        }
    }
}
