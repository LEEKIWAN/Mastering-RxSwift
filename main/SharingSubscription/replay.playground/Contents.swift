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
 # replay, replayAll
 */

// ConnectableObservable은 connect 한순간부터 시퀀스를 만들어 이벤트를 방출한다.

// 그래서 늦게 구독 한 구독자한테는 전 데이터는 받을수가 없는데 받기위해 어케해야하나?

// 버퍼에 저장하고있다가 구독하는 순간에 모두 전달하면 된다.

// replayAll 은 버퍼 사이즈 제한이 없다. 그래서 가능한 사용하지 말아야 한다.

let bag = DisposeBag()

//let replaySubject = ReplaySubject<Int>.create(bufferSize: 5)

//let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(5).multicast(replaySubject)
// 이 방법은 replaysubject를 만들고 파라미터로 전달해야하는 불편함이있다. 그래서 publish 처럼 replay 연산자를 제공한다.

let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(5).replay(5)

source
   .subscribe { print("🔵", $0) }
   .disposed(by: bag)

source
   .delaySubscription(.seconds(4), scheduler: MainScheduler.instance)
   .subscribe { print("🔴", $0) }
   .disposed(by: bag)

source.connect()

