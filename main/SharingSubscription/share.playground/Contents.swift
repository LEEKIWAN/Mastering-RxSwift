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
 # share
 */

//share 연산자는 refCountObservalbe 을 리턴한다.
// share 연산자의 첫번째 파라미터는 replay 즉 버퍼 사이즈를 결정한다.

// 2번째 파라미터는 forever 일 경우 Observable이 종료되어도, 버퍼에 저장된 데이터를 계속 가지고 있는다.

// 하나의 시퀀스만 만들어진다.


let bag = DisposeBag()
//let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().share()

//let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().share(replay: 5)
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().share(replay: 5, scope: .forever)

let observer1 = source
   .subscribe { print("🔵", $0) }

let observer2 = source
   .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
   .subscribe { print("🔴", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
   observer1.dispose()
   observer2.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
   let observer3 = source.subscribe { print("⚫️", $0) }

   DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      observer3.dispose()
   }
}
