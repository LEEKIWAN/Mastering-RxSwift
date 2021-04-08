import UIKit


var str = "Hello, playground"


enum Gender {
    case female
    case male
}

print(Gender.female == Gender.female)


struct MySize {
    let width: Double
    let height: Double
}


// 연관값을 가지는 열거형은 Equatable 을 써주어야한다. 단 -> 연관값들이 전부 Equatable을 채택하고있어야한다.

enum VideoInterface: Equatable {
    case dvi(width: Int, height: Int)
    case hdmi(width: Int, height: Int, version: Double, audioEnabled: Bool)
    case displayPort(size: CGSize)      // MySize로 바꾸면 규칙에 어긋난다. 그래서 MySize에도 Equatable을 채택해야한다.
}

let a = VideoInterface.dvi(width: 100, height: 100)

let b = VideoInterface.hdmi(width: 100, height: 100, version: 100.34, audioEnabled: true)

a == b

////

// 조건은 멤버들도 Equatable을 채택하고있다면
//struct Person: Equatable {
//    let name: String
//    let age: Int
//}
//
//let a1 = Person(name: "Steve", age: 50)
//let b1 = Person(name: "Paul", age: 39)
//
//
//a1 == b1



class Person {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.age == rhs.age && lhs.name == rhs.name
    }
}

let a1 = Person(name: "Steve", age: 50)
let b1 = Person(name: "Paul", age: 39)


a1 == b1


// clsss 와 struct 에서 Equatalbe 을 채택할때 생기는 차이

// struct 에서는 자동으로 == 메소드를 만들어주지만 class 에서는 직접 만들어서 사용해야한다.


