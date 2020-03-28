//
//  GeneratorTests.swift
//  SHListGenLibTests
//
//  Created by Yusuke Hosonuma on 2020/03/27.
//

import XCTest
import SHListGenLib

class GeneratorTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testGenerateFunction() {
        assertEqualLines(generateFunction(count: 1),
        """
        public func HList<T0>(_ t0: T0) -> HList1<T0> {
            HList1(t0)
        }
        """)

        assertEqualLines(generateFunction(count: 2),
        """
        public func HList<T0>(_ t0: T0) -> HList1<T0> {
            HList1(t0)
        }

        public func HList<T0, T1>(_ t0: T0, _ t1: T1) -> HList2<T0, T1> {
            HList2(t0, t1)
        }

        public func HList<T0, T1>(_ v: (T0, T1)) -> HList2<T0, T1> {
            HList2(v.0, v.1)
        }
        """)
    }
    
    func testGenerate() {
        assertEqualLines(generateStruct(count: 1),
        """
        public struct HList1<T0> {
            public let head: T0
            public let count = 1

            public init(_ head: T0) {
                head = head
            }

            public func apply<R>(_ f: (T0) -> R) -> R {
                f(head)
            }
            
            public func asArray() -> [Any] {
                [head]
            }
        }
        """)
        
        assertEqualLines(generateStruct(count: 3),
        """
        public struct HList1<T0> {
            public let head: T0
            public let count = 1

            public init(_ head: T0) {
                head = head
            }

            public func apply<R>(_ f: (T0) -> R) -> R {
                f(head)
            }
            
            public func asArray() -> [Any] {
                [head]
            }
        }

        public struct HList2<T0, T1> {
            public let head: T0
            public let tail: HList1<T1>
            public let count = 2

            public init(_ t0: T0, _ t1: T1) {
                head = t0
                tail = HList1<T1>(t1)
            }
            
            public func apply<R>(_ f: (T0, T1) -> R) -> R {
                f(head, tail.head)
            }
            
            public func asArray() -> [Any] {
                [head, tail.head]
            }
        }

        public struct HList3<T0, T1, T2> {
            public let head: T0
            public let tail: HList2<T1, T2>
            public let count = 3

            public init(_ t0: T0, _ t1: T1, _ t2: T2) {
                head = t0
                tail = HList2<T1, T2>(t1, t2)
            }
            
            public func apply<R>(_ f: (T0, T1, T2) -> R) -> R {
                f(head, tail.head, tail.tail.head)
            }
            
            public func asArray() -> [Any] {
                [head, tail.head, tail.tail.head]
            }
        }
        """)
    }
}
