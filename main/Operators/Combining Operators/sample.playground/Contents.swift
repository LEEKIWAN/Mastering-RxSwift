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
 # sample
 */
// sample 은 WithLatestFrom 과 비슷하지만 파라미터와 호출 인스턴스과 바뀌어있다.

//withLatestFrom 은 Trigger 할 때마다 데이터 옵저버블에서 가장 최신 방출한 데이터를 처리하지만

// sample 은 오직 한번만 방출한다.


let bag = DisposeBag()

enum MyError: Error {
   case error
}


let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()



data.sample(trigger)
    .subscribe {
        print($0)
    }
    .disposed(by: bag)


trigger.onNext(())

data.onNext("Hello")

trigger.onNext(())

trigger.onNext(())

//data.onCompleted()

//trigger.onCompleted()

