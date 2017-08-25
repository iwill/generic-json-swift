import Foundation

extension JSON: Decodable {

    public init(from decoder: Decoder) throws {

        // An object
        if let keyedContainer = try? decoder.container(keyedBy: GenericKey.self) {
            var dict: [String:JSON] = [:]
            for key in keyedContainer.allKeys {
                dict[key.val] = try keyedContainer.decode(JSON.self, forKey: key)
            }
            self = .object(dict)
            return
        }

        // An array
        if var unkeyedContainer = try? decoder.unkeyedContainer() {
            var array: [JSON] = []
            while !unkeyedContainer.isAtEnd {
                array.append(try unkeyedContainer.decode(JSON.self))
            }
            self = .array(array)
            return
        }

        // A single value
        let singleValueContainer = try decoder.singleValueContainer()
        if let str = try? singleValueContainer.decode(String.self) {
            self = .string(str)
        } else if let bool = try? singleValueContainer.decode(Bool.self) {
            self = .bool(bool)
        } else if let num = try? singleValueContainer.decode(Float.self) {
            self = .number(num)
        } else if singleValueContainer.decodeNil() {
            self = .null
        } else {
            throw Error.decodingError
        }
    }
}
