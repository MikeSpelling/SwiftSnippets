import Foundation

struct Generics {
    var booleanContainer: MyCodableHashableStruct<Bool>
    var stringContainer: MyCodableHashableStruct<String>
    
    func doSomething<T>(someStruct: MyCodableHashableStruct<T>) {
        let data = try? JSONEncoder().encode(someStruct)
        print(data as Any)
    }

    func createSomething<T: MyProtocol>(ofType theType: T.Type) -> T {
        if theType is any MyChildProtocol.Type {
            print("Handle specific type")
        }
        if let childProtocolType = theType as? any MyChildProtocol.Type {
            print("Handle specific type \(childProtocolType)")
        }
        let newObject = T.init(2)
        return newObject
    }

    func test() {
        let codableStruct = MyCodableHashableStruct(property: Date())
        let timeIntervalSince1970 = codableStruct.property.timeIntervalSince1970
        
        let concreteObject = createSomething(ofType: MyChildObject.self)
        
        print(timeIntervalSince1970)
        print(concreteObject)
    }
    
}
