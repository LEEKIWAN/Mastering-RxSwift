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
 # PublishSubject
 */
// Subject는 Observable 이면서 동시에 Observer 이다.





let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let subject = PublishSubject<String>()

subject.onNext("Hello World")

subject.subscribe {
    print("1 : ", $0)
}
.disposed(by: disposeBag)


// Subject는 구독한 시점 이후로 부터 이벤트를 받고 처리 할 수 있다.
// 구독하기전 방출한 이벤트는 처리되지 않는다. 이게 문제라면  Replay Subject or cold Observable 응ㄹ 사용한다.



subject.onNext("Ffff")


subject.subscribe {
    print("2 : ", $0)
}
.disposed(by: disposeBag)


subject.onNext("kiwan")

//subject.onCompleted()

subject.onError(MyError.error)


// Complete or Error 이벤트가 방출하면 그다음에 구독하는 이벤트는 무조건 Completre or Event 이다.


subject.subscribe {
    print("3 : ", $0)
}
.disposed(by: disposeBag)

