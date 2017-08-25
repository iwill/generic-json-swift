import Foundation

extension JSON {

    public init<T: Codable>(codable: T) throws {
        let encoded = try JSONEncoder().encode(codable)
        self = try JSONDecoder().decode(JSON.self, from: encoded)
    }
}
