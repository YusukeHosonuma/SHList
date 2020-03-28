
public func generateFunction(count: Int) -> String {
    let head = """
    public func HList<T0>(_ t0: T0) -> HList1<T0> {
        HList1(t0)
    }
    """

    if count == 1 {
        return head
    }

    let tail = (1 ..< count).map { index -> String in

        func _allTypes(_ f: (Int) -> String) -> String {
            (0 ... index).map { f($0) }.joined(separator: ", ")
        }

        let type = "HList\(index + 1)"

        let typeParams = _allTypes { "T\($0)" }
        let params = _allTypes { "_ t\($0): T\($0)" }
        let args = _allTypes { "t\($0)" }
        let tupleArgs = _allTypes { "v.\($0)" }

        return """
        public func HList<\(typeParams)>(\(params)) -> \(type)<\(typeParams)> {
            \(type)(\(args))
        }

        public func HList<\(typeParams)>(_ v: (\(typeParams))) -> \(type)<\(typeParams)> {
            \(type)(\(tupleArgs))
        }
        """
    }

    return ([head] + tail).joined(separator: "\n\n")
}

public func generateStruct(count: Int) -> String {
    let head = """
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
    """

    if count == 1 {
        return head
    }

    let tail = (1 ..< count).map { index -> String in
        let count = index + 1

        func _allTypes(_ f: (Int) -> String) -> String {
            (0 ... index).map { f($0) }.joined(separator: ", ")
        }

        func _tailTypes(_ f: (Int) -> String) -> String {
            (1 ... index).map { f($0) }.joined(separator: ", ")
        }

        let type = "HList\(count)"

        let tailArgs = _tailTypes { "t\($0)" }
        let tailType = "HList\(index)<\(_tailTypes { "T\($0)" })>"

        let types = _allTypes { "T\($0)" }
        let args = _allTypes { "_ t\($0): T\($0)" }

        // e.g. `head, tail.head, tail.tail.head`
        let values = (["head"] + (1 ..< count).map {
            (1 ... $0).map { _ in "tail" }.joined(separator: ".") + ".head"
        }).joined(separator: ", ")

        return """
        public struct \(type)<\(types)> {
            public let head: T0
            public let tail: \(tailType)
            public let count = \(count)

            public init(\(args)) {
                head = t0
                tail = \(tailType)(\(tailArgs))
            }
            
            public func apply<R>(_ f: (\(types)) -> R) -> R {
                f(\(values))
            }
            
            public func asArray() -> [Any] {
                [\(values)]
            }
        }
        """
    }
    return ([head] + tail).joined(separator: "\n\n")
}
