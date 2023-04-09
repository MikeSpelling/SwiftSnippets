import Foundation

class Serialization {
    
    var objectArray: [MyObject] {
        get {
            var storedObjects: [MyObject]?
            if let data = UserDefaults.standard.object(forKey: "key") as? Data {
                storedObjects = try? JSONDecoder().decode([MyObject].self, from: data)
            }
            return storedObjects ?? []
        }
        set {
            if newValue.count <= 0 {
                UserDefaults.standard.removeObject(forKey: "key")
            } else if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "key")
            }
        }
    }
    
    func test() {
        let data = try! JSONSerialization.data(withJSONObject: ["key": "value"])
        if let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] {
            print(json)
        }
    }
}
