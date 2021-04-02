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
 # multicast
 */

// 여러 구독자가 하나의 옵저버블을 공유
// 원본 옵저버블이 방출하는 이벤트는 구독자가 아니라 파라미터 서브젝트로 전달된다.
// 그리고 서브젝트는 등록된 다수의 구독자에게 전달한다.

// connetableObservable은 connect를 한 시점부터 호출한다.
// connetableObservable은 모든 구독자가 원본 옵저버블을 공유한다.

// 원본 옵저버블에서 방출한 이벤트를 모든 구독자에게 전달한다. 시퀀스는 딱 하나!

let bag = DisposeBag()
let subject = PublishSubject<Int>()

let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .multicast(subject)


source
    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
   .subscribe { print("🔵", $0) }
   .disposed(by: bag)

source
   .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
   .subscribe { print("🔴", $0) }
   .disposed(by: bag)


source.connect()        // subscribe 시점이 connect 이다.

source.connect()        // connect는 원본 옵저버블 하나의 시퀀스만 이용가능하다.
