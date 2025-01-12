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
 # timeout
 */


let bag = DisposeBag()

let subject = PublishSubject<Int>()



//subject.timeout(.seconds(4), scheduler: MainScheduler.instance)
//    .subscribe({
//        print($0)
//    })
//    .disposed(by: bag)
//


let other = PublishSubject<Int>()

subject.timeout(.seconds(1), other: other, scheduler: MainScheduler.instance)
    .subscribe({
        print($0)
    })
    .disposed(by: bag)






Observable<Int>.timer(.seconds(2), period: .seconds(6), scheduler: MainScheduler.instance)
    .subscribe({
        subject.onNext($0.element!)
    })
    .disposed(by: bag)


DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
    other.onNext(4)
    other.onCompleted()
})

