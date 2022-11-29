//
//  Mastering RxSwift
//  Copyright (c) KxCoding <help@kxcoding.com>
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
 # scan
 */

// 옵저버블이 방출하는 값을 누적시키는 연산자 -> 중간값과 결과값을 모두 표기한다.

// reduce는 마지막연산된 결과값만 방출하기때문에 버퍼에 넣어놨다가 onComplete 연산이 되어야 호출이 된다.

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()

//subject.scan(0, accumulator: { initVal, acc in
//    return initVal + acc
//})
//.subscribe({
//    print($0)
//})
//.disposed(by: disposeBag)
//
//(0 ... 10).forEach {
//    subject.onNext($0)
//}


var initVal = 0
subject.scan(into: initVal) { initVal, acc in
    initVal += acc
}
.subscribe({
    print($0)
})
.disposed(by: disposeBag)

(0 ... 10).forEach {
    subject.onNext($0)
}

subject.reduce(0) { initVal, acc in
    return initVal + acc
}
.subscribe({
    print($0)
})
.disposed(by: disposeBag)

(0 ... 10).forEach {
    subject.onNext($0)
}
subject.onCompleted()


