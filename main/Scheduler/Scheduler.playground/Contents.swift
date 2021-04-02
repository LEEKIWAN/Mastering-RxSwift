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
 # Scheduler
 */
// 구독 할때 이벤트를 방출한다.
// .observe(on: ) - 다음 실행할 연산자를 파라미터로 전달한 스케쥴러에서 처리하게 한다.
// 한번 호출하면 스케쥴러는 바뀌지 않는다. 다시 .observe(on: ) 을 호출해서 바꿔야 바뀐다.
// .subscribe(on: ) - 구독을 시작하고 방출하기 시작할때 어떤 쓰레드에서 실행하게 할것인가를 결정한다. 그래서 순서에 상관없다.

let backgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())

let bag = DisposeBag()

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .filter { num -> Bool in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
        return num.isMultiple(of: 2)
    }
    .observe(on: backgroundScheduler)
    .map { num -> Int in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
        return num * 2
    }
//    .subscribe(on: backgroundScheduler)
    .subscribe {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> Subscribe : " , $0)
    }
    .disposed(by: bag)




