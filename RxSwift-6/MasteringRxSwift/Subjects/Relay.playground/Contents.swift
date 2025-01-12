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
import RxCocoa

/*:
 # Relay
 */
// subject 를 랩핑해서 만든 릴리에.. -> 완료되는 complete error 이벤트를 내보내지 않는다.


let bag = DisposeBag()


let publishRelay = PublishRelay<Int>()

publishRelay.subscribe {
    print("publish >> \($0)")
}

publishRelay.accept(1)


let behaviorRelay = BehaviorRelay<Int>(value: 1)

behaviorRelay.accept(3)

behaviorRelay.subscribe({
    print("behaviorRelay >> \($0)")
})


print(behaviorRelay.value) // 읽기 전용 속성이다.



let replayRelay = ReplayRelay<Int>.create(bufferSize: 3)

(0 ... 10).forEach {
    replayRelay.accept($0)
}

replayRelay.subscribe({
    print($0)
})






