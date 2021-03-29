//: [Previous](@previous)

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
 # throttle
 ## latest parameter
 */


// latest 변수 값에 따라서 결과가 달라진다.

// default: true 이며, 정확한 시간 간격을 지킨다. 최근에 방출된 값을 구독자에게 전달한다.
// no 일경우 시간 간격 이후 방출된 값을 구독자에가 전달하므로, 간격보다 더 늦게 넥스트 이벤트가 전달될수 있다.


let disposeBag = DisposeBag()

func currentTimeString() -> String {
   let f = DateFormatter()
   f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
   return f.string(from: Date())
}


//Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//   .debug()
//   .take(10)
//   .throttle(.milliseconds(2500), latest: true, scheduler: MainScheduler.instance)
//   .subscribe { print(currentTimeString(), $0) }
//   .disposed(by: disposeBag)


Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
   .debug()
   .take(10)
   .throttle(.milliseconds(2500), latest: false, scheduler: MainScheduler.instance)
   .subscribe { print(currentTimeString(), $0) }
   .disposed(by: disposeBag)
 
