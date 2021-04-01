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
 # timeout
 */
// timout 무한히 timeout check 하는 함수
// timeout 시간 내에 새로운 이벤트가 방출되지 않으면, error 를 방출하고 종료한다.
// 2번째 인자는 error 대신 방출할 이벤트를 설정할수 있다.


let bag = DisposeBag()

let subject = PublishSubject<Int>()


//subject.timeout(.seconds(3), scheduler: MainScheduler.instance)
subject.timeout(.seconds(3), other: Observable.just(100), scheduler: MainScheduler.instance)
    .subscribe {
        print($0)
    }
    .disposed(by: bag)



Observable<Int>.timer(.seconds(2), period: .seconds(5), scheduler: MainScheduler.instance)
    .subscribe {
        subject.onNext($0)
    }
    .disposed(by: bag)
