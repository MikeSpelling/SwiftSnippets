import Foundation

// MARK: - Codable
protocol MyCodableProtocol: Codable {
    var property: Int { get }
}
protocol MyHashableProtocol: Hashable {
    var property: Int { get }
}
protocol MyCodableHashableProtocol: MyCodableProtocol, MyHashableProtocol {
    var property: Int { get }
}

struct MyConcreteCodableStruct: MyCodableProtocol {
    var property: Int
}
struct MyConcreteHashableStruct: MyHashableProtocol {
    var property: Int
}
struct MyConcreteCodableHashableStruct: MyCodableProtocol, MyHashableProtocol {
    var property: Int
}

// MARK: - Conformance
protocol MyProtocol: MyCodableProtocol, MyHashableProtocol {
    var property: Int { get }
    init(_ property: Int)
}
struct MyStruct: MyProtocol {
    var property: Int
    init(_ property: Int) {
        self.property = property
    }
}
protocol MyChildProtocol: MyProtocol {
    var childProperty: Int { get }
}
struct MyChildStruct: MyChildProtocol {
    var property: Int
    var childProperty: Int
    init(_ property: Int) {
        self.property = property
        self.childProperty = 1
    }
}

// MARK: - Struct
struct MyConcreteStruct: Identifiable {
    var uidString: String = MyObject.uidString
    var int: Int = MyObject.int
    var double: Double = MyObject.double
    var timeInterval: TimeInterval = MyObject.timeInterval
    var string: String = MyObject.string
    var data: Data = MyObject.data
    var optionalInt: Int? = MyObject.optionalInt
    var optionalString: String? = MyObject.optionalString
    var dateConstant: Date = MyObject.dateConstant
    var dateNow: Date = MyObject.dateNow
    var error: NSError { NSError(domain: string, code: int) }
    
    var id: String { uidString }
}
struct MyCodableHashableStruct<T: Codable&Hashable>: Codable, Hashable {
    var property: T
}

// MARK: - Object
class MyObject: Codable, Hashable, Comparable, Identifiable {
    var uidString: String
    var int: Int
    var double: Double
    var timeInterval: TimeInterval
    var string: String
    var data: Data
    var optionalInt: Int?
    var optionalString: String?
    var dateConstant: Date
    var dateNow: Date
    var error: NSError { NSError(domain: string, code: int) }
    
    var id: String { uidString }
    
    init(uidString: String = MyObject.uidString,
         int: Int = MyObject.int,
         double: Double = MyObject.double,
         timeInterval: TimeInterval = MyObject.timeInterval,
         string: String = MyObject.string,
         data: Data = MyObject.data,
         optionalInt: Int? = MyObject.optionalInt,
         optionalString: String? = MyObject.optionalString,
         dateConstant: Date = MyObject.dateConstant,
         dateNow: Date = MyObject.dateNow) {
        self.uidString = uidString
        self.int = int
        self.double = double
        self.timeInterval = timeInterval
        self.string = string
        self.data = data
        self.optionalInt = optionalInt
        self.optionalString = optionalString
        self.dateConstant = dateConstant
        self.dateNow = dateNow
    }
    
    // Equatable
    static func == (lhs: MyObject, rhs: MyObject) -> Bool {
        lhs.uidString == rhs.uidString
    }
    // Comparable
    static func < (lhs: MyObject, rhs: MyObject) -> Bool {
        lhs.string < rhs.string
    }
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(uidString)
        hasher.combine(int)
        hasher.combine(double)
        hasher.combine(timeInterval)
        hasher.combine(string)
        hasher.combine(dateConstant)
        hasher.combine(dateNow)
        hasher.combine(data)
        hasher.combine(error)
    }
}

class MyChildObject: MyObject, MyProtocol {
    var property: Int
    var childProperty: Int
    
    required init(_ childProperty: Int) {
        self.property = 1
        self.childProperty = childProperty
        super.init()
    }
    
    // Codable
    private enum CodingKeys: String, CodingKey {
        case property, childProperty
    }
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.property = try container.decode(Int.self, forKey: .property)
        self.childProperty = try container.decode(Int.self, forKey: .childProperty)
        try super.init(from: decoder)
    }
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(childProperty, forKey: .childProperty)
    }
}

// MARK: - Enum
enum MyEnum: Codable, Hashable, Comparable, CaseIterable {
    case one, two, three
    case withInt(Int)
    case withString(String)
    case withIntAndString(int: Int, string: String)
    
    var asInt: Int {
        switch self {
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .withInt(let int): return int
        case .withString(let string): return Int(string) ?? 0
        case let .withIntAndString(int, _): return int
        }
    }
    var asString: String {
        switch self {
        case .one: return "one"
        case .two: return "two"
        case .three: return "three"
        case .withInt(let int): return String(int)
        case .withString(let string): return string
        case let .withIntAndString(_, string): return string
        }
    }
    
    // CaseIterable
    static var allCases: [MyEnum] {
        [
            .one, .two, .three,
            .withInt(1), .withInt(2), .withInt(3),
            .withString("one"), .withString("two"), .withString("three"),
            .withIntAndString(int: 1, string: "one"),
            .withIntAndString(int: 2, string: "two"),
            .withIntAndString(int: 3, string: "three")
        ]
    }
}

extension MyObject {
    static var uidString = UUID().uuidString
    static var int: Int = 1
    static var double: Double = 1.5
    static var timeInterval: TimeInterval = 1
    static var string = "string"
    static var data: Data = UUID().uuidString.data(using: .utf8)!
    static var optionalInt: Int?
    static var optionalString: String?
    static var dateConstant: Date = Date(timeIntervalSince1970: 0)
    static var dateNow: Date = Date()
    static var error: NSError { NSError(domain: string, code: int) }
}
