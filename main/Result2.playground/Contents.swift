import UIKit

guard let url = URL(string: "http://kxcoding-study.azurewebsites.net/api/books") else {
    fatalError("invalid url")
}

struct BookListData: Codable {
    let code: Int
    let totalCount: Int
    let list: [Book]
}

struct Book: Codable {
    let title: String
}

enum APIError: Error {
    case general
    case invalidFormat
}


typealias CompletionHandler = (Result<BookListData, APIError>) -> Void

func parseBookList(completion: @escaping CompletionHandler) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(.failure(.general))
            return
        }
        
        guard let data = data else {
            completion(.failure(.general))
            return
        }
        
        do {
            let list = try JSONDecoder().decode(BookListData.self, from: data)
            completion(.success(list))
        } catch {
            completion(.failure(.invalidFormat))
        }
    }
    task.resume()
}

parseBookList { result in
    switch result {
    case .success(let list):
        print(list)
    case .failure(let error):
        
        switch error {
        case .general:
            break
        case .invalidFormat:
            break
        }
        print(error.localizedDescription)
    }
}



//typealias CompletionHandler = (BookListData?, Error?) -> ()
//
//func parseBookList(completion: @escaping CompletionHandler) {
//   let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//      if let error = error {
//         completion(nil, error)
//         return
//      }
//
//      guard let data = data else {
//         completion(nil, nil)
//         return
//      }
//
//      do {
//         let list = try JSONDecoder().decode(BookListData.self, from: data)
//         completion(list, nil)
//      } catch {
//         completion(nil, error)
//      }
//   }
//   task.resume()
//}
//
//parseBookList { (data, error) in
//   if let error = error {
//      print(error.localizedDescription)
//      return
//   }
//
//   data?.list.forEach { print($0.title) }
//}



// --------------------------------------------------------------------------------------------------


enum MyError: Error {
    case error

}

enum ValueError: Error {
    case evenNumber
}

func doSomethingWithResult(data: Int) -> Result<Int, MyError> {
    guard data.isMultiple(of: 2) else { return .failure(.error) }
    
    return .success(data)
}


let val = doSomethingWithResult(data: 2)

print(val)

let val2 = val.map { value in
    "짝수입니다."
}

print(val2)

let val3 = val.flatMap {
    $0 > 0 ? .success("짝수입니다.") : .failure(.error)
}

print(val3)
