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
 # toArray
 */

// 방출된 여러개의 이벤트를 배열로 합쳐 하나의 이벤트만 방출한다.
// 하나의 이벤트가 방출되기때문에 마지막 onComplete 가 있어야 이벤트를 방출한다.
// Error 이벤트가 있으면 방출하지 않고 오류를 표시한다.
// Single 객체를 사용한다. Single 하나의 이벤트를 방출하거나 Error 이벤트를 방출한다.

enum MyError: Error {
    case error
}

let disposeBag = DisposeBag()


let publish = PublishSubject<Int>()

publish
    .toArray()
    .subscribe {
        print($0)
    }


publish.onNext(1)
publish.onNext(3)
publish.onNext(5)

publish.onCompleted()
//publish.onError(MyError.error)


