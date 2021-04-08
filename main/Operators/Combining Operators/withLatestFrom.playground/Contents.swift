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
 # withLatestFrom
 */

// triggerObservable.withLatestFrom(dataObservable)

// 트리거 옵저버블, 데이터 옵저버블 2가짛 형태로 부른다.

// 트리거 옵저버블이 넥스트 이벤트를 방출하면 데이터옵저버블에서 가장 최근에 방출한 이벤트를 방출한다.
// dataObservable 에서 onComplete 해도 trigger에서 complete를 방출하지 않지만, onError를 하면 trigger에서 에러를 방출한다.


// triggerObservable 에서 컴플리트나 에러를 방출하면 바로 종료가된다.
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()


trigger.withLatestFrom(data)
    .subscribe {
        print($0)
    }
    .disposed(by: bag)


data.onNext("Hello")

trigger.onNext(())
trigger.onNext(())

//data.onCompleted()
//data.onError(MyError.error)
//trigger.onNext(())

trigger.onCompleted()





//saveButton.rx.tap
//    .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
//    .withLatestFrom(contentTextView.rx.text.orEmpty)
//    .bind(to: viewModel.saveAction.inputs)
//    .disposed(by: rx.disposeBag)



//let buttonObservable = PublishSubject<Void>()
//let text = BehaviorSubject<String>(value: "Hell World")
////
//
//buttonObservable.throttle(.milliseconds(3000), latest: true, scheduler: MainScheduler.instance)
//    .withLatestFrom(text)
//    .subscribe {
//        print($0)
//    }
//    .disposed(by: bag)
////
////
//buttonObservable.onNext(())
//buttonObservable.onNext(())
//buttonObservable.onNext(())
//buttonObservable.onNext(())
//buttonObservable.onNext(())
//buttonObservable.onNext(())
////
//
//buttonObservable.onCompleted()

