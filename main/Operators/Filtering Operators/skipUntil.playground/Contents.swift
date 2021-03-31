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
 # skipUntil
 */

// skipUntil은 파라미터를 ObservableType을 받는다.
// 그리고 파라미터로 받은 Observable이 next를 방출하기 전까지 원 Observable은 next 이벤트를 방출하지 않는다.
// 그래서 파라미터는 보통 트리거로 불려지기도 한다.


let disposeBag = DisposeBag()




let publish = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

publish.onNext(0)

publish.skip(until: trigger)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

publish.onNext(1)

publish.onNext(2)

trigger.onNext(100)

publish.onNext(3)

publish.onNext(4)
