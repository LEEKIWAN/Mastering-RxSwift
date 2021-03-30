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
 # merge
 */


// 2개 이상의 observable을 하나의 옵저버블로 만든다.
// concat과 merge는 observable 을 연결하는 점에는 같지만, concat 은 하나의 옵저버블이 완료가 되어야 다음 옵저버블이 방출되지만,
// merge는 옵저버블 순서 상관없이 방출하는 이벤트 순을 따른다.

// merge 된 모든 observerble이 모두 컴플리트가 되어야 컴플리트된ㄴ다.
// 하나라도 에러를 방출하면 모든 이벤트를 방출하지 않는다.
// merge 할 observable의 최대 갯수를 정할수있다. maxConcurrent보다 많은 Observable을 구독하면 Queue 에 들어가서 다른 것이 complete 되길 기다린다.

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)



Observable<BehaviorSubject<Int>>.of(oddNumbers, evenNumbers, negativeNumbers)
    .merge(maxConcurrent: 2)
    .subscribe {
        print($0)
        
    }
    .disposed(by: bag)




oddNumbers.onNext(3)
evenNumbers.onNext(4)

//oddNumbers.onError(MyError.error)

oddNumbers.onNext(5)
evenNumbers.onNext(6)

negativeNumbers.onNext(-2)

evenNumbers.onCompleted()



//oddNumbers.onCompleted()
//
//evenNumbers.onNext(8)
//
//evenNumbers.onCompleted()
