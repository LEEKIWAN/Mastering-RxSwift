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
 # refCount
 */
// refCount 는 ConnectableObservable 메소드이다. 그래서 connect 함수를 호출할 필요가 없다.
// 이벤트 방출할 구독자가 생기면 바로 connect 를 호출해주고 구독자가 종료되서 방출해줄 구독자가 없다면, 자동으로 disconnect 해준다.
// publish, replay 같은경우 take 로 종료시점을 처리해주었다면,
// reCount는 메모리를 알아서 관리해주기때문에 편하다.


// refCountObservable 이라고도 불린다.

let bag = DisposeBag()

let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().publish().refCount()

let observer1 = source
   .subscribe { print("🔵", $0) }

//source.connect()

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
   observer1.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
   let observer2 = source.subscribe { print("🔴", $0) }

   DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      observer2.dispose()
   }
}








