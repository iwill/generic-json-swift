Swift 4 introduced a new JSON encoding and decoding machinery represented by the `Codable` protocol. The feature is very nice and very type-safe, meaning it’s no longer possible to just willy-nilly decode a JSON string pulling random untyped data from it. Which is good™ most of the time – but what should you do when you _do_ want to just willy-nilly encode or decode a JSON string without introducing a separate, well-typed structure for it? For example:

```
// error: heterogeneous collection literal could only be inferred to '[String : Any]';
// add explicit type annotation if this is intentional
let json = [
    "foo": "foo",
    "bar": 1,
]

// Okay then:
let json: [String:Any] = [
    "foo": "foo",
    "bar": 1,
]

// But: fatal error: Dictionary<String, Any> does not conform to Encodable because Any does not conform to Encodable.
let encoded = try JSONEncoder().encode(json)
```

So this doesn’t work very well. Also, the `json` value can’t be checked for equality with another, although arbitrary JSON values _should_ support equality. Enter `JSON`:

```
let json: JSON = [
    "foo": "foo",
    "bar": 1,
]

// "{"bar":1,"foo":"foo"}"
let str = try String(data: try JSONEncoder().encode(json), encoding: .utf8)!
let hopefullyTrue = (json == json) // true!
```

Also, you can turn any `Encodable` object into a generic JSON structure:

```
struct Player: Codable {
    let name: String
    let swings: Bool
}

let val = try JSON(encodable: Player(name: "Miles", swings: true))
val == [
    "name": "Miles",
    "swings": true,
] // true
```