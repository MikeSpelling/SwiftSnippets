import XCTest
@testable import SwiftSnippets

final class SwiftSnippetsTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testSerialization() {
        Serialization().test()
    }
    func testAssociatedTypes() {
        AssociatedTypes().test()
    }
    func testDateFormats() {
        DateFormats().test()
    }
}
