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
 # BehaviorSubject
 */

// BehaviorSubject는 초기 이벤트를 하나 가지고 있고, 구독하는 시점에 바로 초기이벤트를 전달해준다.

// 구독하기전에 넥스트이벤트를 방출하면, 기존 초기이벤트가 대체 된다.

// 그외에는 PublishSubject 와 똑같다.



let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let p = PublishSubject<Int>()

p.subscribe {
    print("PublishSubejct >> ", $0)
}
.disposed(by: disposeBag)


let b = BehaviorSubject<Int>(value: 4)

b.onNext(10)

b.subscribe {
    print("BehaviorSubject >> ", $0)
}
.disposed(by: disposeBag)

b.onNext(100)


b.subscribe {
    print("BehaviorSubject222 >> ", $0)
}
.disposed(by: disposeBag)


//b.onCompleted()
b.onError(MyError.error)


b.subscribe {
    print("BehaviorSubject333> ", $0)
}
.disposed(by: disposeBag)
