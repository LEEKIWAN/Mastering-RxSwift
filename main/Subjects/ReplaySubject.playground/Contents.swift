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
 # ReplaySubject
 */

// Publish Subject 는 구독하기전 이벤트는 처리 하지 않는다.
// Behavior Subject 는 구독한 시점에 단 하나의 이벤트를 처리 한다.

// Replay Subject는 버퍼에 있는 이벤트를 구독한 시점에 한꺼번에 처리 한다.
// 버퍼는 메모리에 저장되기때문에 필요 이상으로 만들면 안된다.

// onCompelete or Error 이벤트를 전달되어도 버퍼에 있는 이벤트를 모두 처리한 후에 Complete eroror 이벤트를 처리한다.

// 항상 버퍼에 있는 이벤트를 처리한다.



let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let r = ReplaySubject<Int>.create(bufferSize: 3)

(1 ... 10).forEach {
    r.onNext($0)
}

r.subscribe {
    print("Observable 1 >> " , $0)
}


r.subscribe {
    print("Observable 2 >> " , $0)
}

r.onNext(11)



r.subscribe {
    print("Observable 3 >> " , $0)
}

//r.onCompleted()
r.onError(MyError.error)

r.subscribe {
    print("Observable 4 >> " , $0)
}
