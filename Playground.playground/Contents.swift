import Cocoa
import GenericJSON

let json: JSON = [
    "foo": "bar",
    "bar": 1,
    "empty": nil,
]

let str = try String(data: try JSONEncoder().encode(json), encoding: .utf8)!
