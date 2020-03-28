# SHList

[![CocoaPods](https://img.shields.io/cocoapods/v/SHList.svg)](https://cocoapods.org/pods/SHList)
![SPM Compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)
[![License](https://img.shields.io/github/license/YusukeHosonuma/SHList)](https://github.com/YusukeHosonuma/SHList/blob/master/LICENSE)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2Ftobi462)](https://twitter.com/tobi462)

SHList is HList for Swift by statically meta-programming.

![Screenshot](https://raw.githubusercontent.com/YusukeHosonuma/SHList/master/Images/screenshot.png)

```swift
let list = HList("Hello", 42, true)

list.head           // => "Hello"
list.tail.head      // => 42
list.tail.tail.head // => true

list.count           // => 3
list.tail.count      // => 2
list.tail.tail.count // => 2

list.asArray() // => ["Hello", 42, true] as [Any]

func f(a1: String, a2: Int, a3: Bool) -> String {
    "\(a1),\(a2),\(a3)"
}

list.apply(f) // => "Hello,42,true"
```

## Limitation

Only up to **20 elements** are supported.

## Author

Yusuke Hosonuma / tobi462@gmail.com / [@tobi462](https://twitter.com/tobi462)

## License

[SHList](https://github.com/YusukeHosonuma/SHList) is available under the MIT license. See the LICENSE file for more info.
