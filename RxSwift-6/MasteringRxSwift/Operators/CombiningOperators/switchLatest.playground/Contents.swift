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
 # switchLatest
 */

// 방출하는 값이 Observable 타입이여한다.!! sourceObservable이 방출하는값을 방출한다. ->

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()



let source = PublishSubject<PublishSubject<String>>()

//a.onNext("d")

source
    .switchLatest()
    .subscribe({
        print($0)
    })
    .disposed(by: bag)


a.onNext("one")

source.onNext(a)

a.onNext("a one")
b.onNext("b one")

source.onNext(b)

a.onNext("a one")
b.onNext("b one")


b.onCompleted()
source.onCompleted()
