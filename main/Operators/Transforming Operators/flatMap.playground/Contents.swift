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
 # flatMap
 */

// flatmap 은 파라미터로 클로져를 받고 ObservableConvertibleType 형태로 리턴해야한다.
// 즉 옵저버블 형태로 변환하고 -> 자식 옵저버블을 가지게 된다.  ( 하나의 옵저버블이 관리한다.)
// 부모의 onNext는 자식을 추가 하는 형식이고 자식의 onNext는 부모로 이벤트를 전달하는 형태이다.
// 자식의 모든 옵저버블이 onComplete 방출한 후 부모 옵저버블도 complete 해줘야 onOComplete 을 방출한다.

// 네트워크 요청을 구현할때 사용된다.

let disposeBag = DisposeBag()


let b1 = BehaviorSubject<Int>(value: 1)

let b2 = BehaviorSubject<Int>(value: 2)


let subject = PublishSubject<BehaviorSubject<Int>>()

subject
    .flatMap({
        $0.asObservable()
    })
    .subscribe {
    print($0)
}
.disposed(by: disposeBag)

subject.onNext(b1)

//subject.onNext(b2)
//subject.onNext(b1)

b1.onNext(4)
b2.onNext(78)
//
//b1.onCompleted()
//b2.onCompleted()
//
//subject.onCompleted()

