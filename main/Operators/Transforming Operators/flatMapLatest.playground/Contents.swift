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
 # flatMapLatest
 */

// 가장 최근 추가된 자식 옵저버블 하나만 보며, 자식 옵저버블이 방출한 이벤트만 처리힌다.

let disposeBag = DisposeBag()

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject
    .flatMapLatest { $0.asObservable() }
   .subscribe { print($0) }
   .disposed(by: disposeBag)



subject.onNext(a)

a.onNext(1)

subject.onNext(b)

b.onNext(22)
a.onNext(11)

subject.onNext(a)

b.onNext(222)

a.onNext(111)


a.onCompleted()
subject.onCompleted()

