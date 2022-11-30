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
 # merge
 */
// 여러 옵저버블을 하나의 옵저버블로 바꾼다.
// sourceObservable이 모두 complete 해야 resultObservable이 complete 된다.

let bag = DisposeBag()


enum MyError: Error {
   case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)






//Observable<Int>.merge([oddNumbers, evenNumbers, negativeNumbers])
//    .subscribe({
//        print($0)
//    })
//    .disposed(by: bag)
//
//evenNumbers.onNext(4)
//
//negativeNumbers.onNext(-2)


Observable<BehaviorSubject<Int>>.of(oddNumbers, evenNumbers, negativeNumbers)
    .merge(maxConcurrent: 2)
    .subscribe({
        print($0)
    })
    .disposed(by: bag)


oddNumbers.onNext(3)
evenNumbers.onNext(4)


negativeNumbers.onNext(5) 

//oddNumbers.onCompleted()



