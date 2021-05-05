import UIKit



enum NumberError: Error {
    case negativeNumber
    case evenNumber
}

enum AnotherError: Error {
    case tooLarge
}

func process(oddNumber: Int) throws -> Int {
    guard oddNumber % 2 != 0 else { throw NumberError.evenNumber }
    guard oddNumber >= 0 else { throw NumberError.negativeNumber }
    guard oddNumber < 1000 else { throw AnotherError.tooLarge }
    return oddNumber * 2
}

let result = Result {
    try process(oddNumber: 1)
}

switch result {
case .success(let val):
    print(val)
case .failure(let error):
    print(error)
}



func processResult(oddNumber: Int) -> Result<Int, NumberError> {
    guard oddNumber % 2 != 0 else { return .failure(.evenNumber) }
    guard oddNumber >= 0 else { return .failure(.negativeNumber)}
//    guard oddNumber < 1000 else { throw AnotherError.tooLarge }
    return .success(oddNumber * 2)
}


let t2 = processResult(oddNumber: 1)

if let val = try? t2.get() {
    print("get" , val)
}


//do {
//    let b = try process(oddNumber: -1)
//
//    print(b)
//}
//catch let err as NumberError {
//    switch err {
//    case .evenNumber:
//        print("even")
//    case .negativeNumber:
//    print("nagative")
//    }
//}
//catch {
//    print(error.localizedDescription)
//}


