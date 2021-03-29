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
 # Relay
 */

// Relay는 2가지 Publish Relay, Behavior Relay가 있다.
// onComplete , Error 이벤트가 없다. 넥스트 이벤트만 있다.
// 구독자가 Dispose 될때 까지 종료가 되지 안흔ㄴ다.
// 그래서 주로 UI에서 쓰인다.

// Relay 는 rxcoca 프레임워크다.

let bag = DisposeBag()

let publishReplay = PublishRelay<Int>()


publishReplay.accept(3)

publishReplay.subscribe {
    print("1 : ", $0)
}
.disposed(by: bag)


publishReplay.accept(3)

let behaviorRelay = BehaviorRelay<Int>(value: 4)

behaviorRelay.subscribe {
    print("2 : ", $0)
}
.disposed(by: bag)

behaviorRelay.accept(5)

print(behaviorRelay.value)

//BehaviroRelay 에는 value 속성이 있다. 마지막으로 전달된 이벤트가 저장되있다. 값을 바꾸고시픙면, accept를 호출하면 된다. 
