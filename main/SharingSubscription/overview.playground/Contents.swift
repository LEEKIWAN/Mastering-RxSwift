//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # Sharing Subscription
 */

// 시퀀스는 구독하는 순간부터 매번 구독할때마다 생긴다.
// 시퀀스들은 비동기 작업 (서버 통신, DB작업)을 여러번 하게 되면, 자원을 낭비하게 된다.
// 자원을 낭비 하지않기 위해 share 연산자를 사용한다.
// 시퀀스를 딱 한번 실행한다.

let bag = DisposeBag()

let source = Observable<String>.create { observer in
   let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/string")!
   let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data, let html = String(data: data, encoding: .utf8) {
         observer.onNext(html)
        print("onNext")
      }
      
      observer.onCompleted()
   }
    
   task.resume()
   
   return Disposables.create {
      task.cancel()
   }
}
.debug()
.share()

source.subscribe {
    print($0)
}
.disposed(by: bag)

source.subscribe {
    print($0)
}
.disposed(by: bag)

//source.subscribe().disposed(by: bag)
//source.subscribe().disposed(by: bag)
//source.subscribe().disposed(by: bag)

DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    source.subscribe {
        print($0)
    }
    .disposed(by: bag)
}
      
