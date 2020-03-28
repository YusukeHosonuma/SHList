//
//  GeneratorTests.swift
//  SHListGenLibTests
//
//  Created by Yusuke Hosonuma on 2020/03/27.
//

import XCTest
import SHList

class GeneratorTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testGenerate() {
        func f1(_ a1: String) -> String {
            "\(a1)"
        }

        func f2(_ a1: String, _ a2: Int) -> String {
            "\(a1),\(a2)"
        }
        
        func f3(_ a1: String, _ a2: Int, _ a3: Bool) -> String {
            "\(a1),\(a2),\(a3)"
        }

        let h1 = HList("Hello")
        XCTAssertEqual(h1.count, 1)
        XCTAssertEqual(h1.head, "Hello")
        XCTAssertEqual(h1.apply(f1), "Hello")
        XCTAssertEqual(h1.asArray().count, 1)
        XCTAssertEqual(h1.asArray()[0] as? String, "Hello")
        
        for h2 in [
            HList("Hello", 42),
            HList(("Hello", 42))
        ] {
            XCTAssertEqual(h2.count, 2)
            XCTAssertEqual(h2.head, "Hello")
            XCTAssertEqual(h2.tail.head, 42)
            XCTAssertEqual(h2.apply(f2), "Hello,42")
            XCTAssertEqual(h2.asArray().count, 2)
            XCTAssertEqual(h2.asArray()[0] as? String, "Hello")
            XCTAssertEqual(h2.asArray()[1] as? Int, 42)
        }
        
        for h3 in [
            HList("Hello", 42, true),
            HList(("Hello", 42, true)),
        ] {
            XCTAssertEqual(h3.count, 3)
            XCTAssertEqual(h3.head, "Hello")
            XCTAssertEqual(h3.tail.head, 42)
            XCTAssertEqual(h3.tail.tail.head, true)
            XCTAssertEqual(h3.apply(f3), "Hello,42,true")
            XCTAssertEqual(h3.asArray().count, 3)
            XCTAssertEqual(h3.asArray()[0] as? String, "Hello")
            XCTAssertEqual(h3.asArray()[1] as? Int, 42)
            XCTAssertEqual(h3.asArray()[2] as? Bool, true)
        }
    }
}
