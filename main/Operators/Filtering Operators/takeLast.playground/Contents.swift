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
 # takeLast
 */
// 파라미터 갯수만큼 마지막 이벤트만 버퍼에 저장해둔다. 넥스트 이벤트를 방출하기 전까지 버퍼에 저장해두고 방출하지 않는다.
// onComplete가 호출되면 버퍼에 저장되엉있던 이벤트를 모두 방출한다음 onComplete가 방출된다.
// error가 호출되면 버퍼에 있는 값도 방출안되고 error만 방출된다.


enum MyError: Error {
   case error
}

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let publish = PublishSubject<Int>()


publish.takeLast(2)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)


numbers.forEach {
    publish.onNext($0)
}

publish.onNext(11)

publish.onCompleted()

//publish.onError(MyError.error)
