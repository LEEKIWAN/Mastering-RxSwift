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
import RxCocoa

/*:
 # AsyncSubject
 */

// complete 이벤트가 처리 되기 전까진 어떤 이벤트를 처리 하지 않는다.

// complete 이벤트가 방출 되면 가장 최신이벤트 하나를 구독자로 전달해주고 바로 complete 이벤트가 처리된다.

// error 이벤트는 최신이벤트 없이 바로 error 이벤트 하나만을 처리한다.

let bag = DisposeBag()

enum MyError: Error {
   case error
}




let subject = AsyncSubject<Int>()

subject.subscribe {
    print($0)
}
.disposed(by: bag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

subject.onCompleted()

//subject.onError(MyError.error)


