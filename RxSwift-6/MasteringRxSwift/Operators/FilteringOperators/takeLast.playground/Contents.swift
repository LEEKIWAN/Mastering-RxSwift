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
 # takeLast
 */

// 마지막 n개의 이벤트를 전달하기 때문에 버퍼에 항상 저장해놓고 있다.
// 때문에 complete 이벤트가 전달되어야 버퍼에 있는 이벤트를 방출할수가 있다.
// Error 일경우 에러 이벤트만 방출된다.

// 전달시점이 마지막이다..!!!

enum MyError: Error {
    case error
}

let disposeBag = DisposeBag()
let subject = PublishSubject<Int>()

subject.takeLast(2)
    .subscribe({
        print($0)
    })
    .disposed(by: disposeBag)


subject.onNext(1)
subject.onNext(2)
subject.onNext(3)
subject.onNext(4)

//subject.onCompleted()
subject.onError(MyError.error)
