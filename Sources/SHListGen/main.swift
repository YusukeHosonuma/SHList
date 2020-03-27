//
//  main.swift
//  SHListGen
//
//  Created by Yusuke Hosonuma on 2020/03/27.
//

import Foundation
import SHListGenLib

let generateCount = 20

let output = """
//
// This source is automatically generated.
//

\(generateFunction(count: generateCount))

\(generateStruct(count: generateCount))
"""

let outputPath = "Sources/SHList/SHList.swift"
let currentPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let flattenSwiftPath = currentPath.appendingPathComponent(outputPath)

do {
    try output.write(to: flattenSwiftPath, atomically: true, encoding: String.Encoding.utf8)
    print("Finished, source file written at \(outputPath) 🎉")
} catch {
    print("Error: \(error)")
}
