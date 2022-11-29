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
 # throttle
 */


// latest 변수 ..-> 보통 true 를 사용한다.
// true: 타이머 주기가 되면, 최근에 방출된값이 있다면 방출한다.
// false: 타이머 주기가 끝나면, 끝난 후 방출된 값을 방출한다.


let disposeBag = DisposeBag()

let buttonTap = Observable<String>.create { observer in
   DispatchQueue.global().async {
       
       
       observer.onNext("one")
       
       Thread.sleep(forTimeInterval: 0.5)
       
       observer.onNext("two")
       
//       Thread.sleep(forTimeInterval: 0.5)
//
//       observer.onNext("three")
//
//
//       Thread.sleep(forTimeInterval: 0.5)
//
//       observer.onNext("four")
      
      observer.onCompleted()
   }
   
   return Disposables.create {
      
   }
}


buttonTap
    .debug()
    .throttle(.seconds(2), latest: false, scheduler: MainScheduler.instance)
   .subscribe { print($0) }
   .disposed(by: disposeBag)



//: [Next](@next)
