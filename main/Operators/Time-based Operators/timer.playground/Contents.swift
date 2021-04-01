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
 # timer
 */
// interval 과 마찬가지로 정수를 방출한다.
// timer에서 첫번째 파라미터는 구독한 이후 처음 방출되기 까지 걸리는 시간
// 두번째 파라미터가 nil(default) 이라면 처음 이벤트만 방출되고 종료 한고, 파라미터가 있으면 주기마다 무한정 방출하는 옵저버블을 만든다.
let bag = DisposeBag()


//Observable<Int>.timer(.seconds(2), scheduler: MainScheduler.instance)
//    .subscribe {
//        print($0)
//    }
//    .disposed(by: bag)


Observable<Int>.timer(.seconds(2), period: .milliseconds(500), scheduler: MainScheduler.instance)
    .subscribe {
        print("Second ", $0)
    }
    .disposed(by: bag)

