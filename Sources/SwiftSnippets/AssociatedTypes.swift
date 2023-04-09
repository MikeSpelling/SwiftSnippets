import Foundation

protocol RandomGenerator {
    associatedtype RandomThing
    func getRandom() -> RandomThing
}
struct IntRandomGenerator: RandomGenerator {
    typealias RandomThing = Int
    func getRandom() -> RandomThing { Int.random(in: 0..<1) }
}
struct DateRandomGenerator: RandomGenerator {
    typealias RandomThing = Date
    func getRandom() -> RandomThing { Date(timeIntervalSinceNow: TimeInterval.random(in: (1...60))) }
}

protocol Printer {
    associatedtype Item
    var theItem: Item { get set }
    func printFormatted()
}
struct StringPrinter: Printer {
    var theItem: Float
    func printFormatted() { print(String(format: "%.02f", theItem)) }
}
struct DatePrinter: Printer {
    var theItem: Date
    func printFormatted() {
        let df = DateFormatter()
        print(df.string(from: theItem))
    }
}

class AssociatedTypes {
    func test() {
        if IntRandomGenerator().getRandom() == 1 {
            let randomTimeInterval = DateRandomGenerator().getRandom().timeIntervalSince(Date())
            print(randomTimeInterval)
        }
        
        StringPrinter(theItem: 0.4).printFormatted()
        DatePrinter(theItem: Date()).printFormatted()
    }
}
