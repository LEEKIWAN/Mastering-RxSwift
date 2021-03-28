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
 # Disposables
 */
// onDisposed은 observable이 전달하는 이벤트가 아니다.
// completed 나 error 이벤트를 받으면 자동으로 메모리에서 해제된다.
// 하지만 메모리를 직접 관리하는걸 권고한다.

// 메모리 해제 할때 , 진행중인 이벤트를 취소할 때 쓰인다.

let sub1 = Observable.from([1, 2, 3])
    .subscribe(onNext: {element in
        print("Next", element)
    }, onError: { error in
        print("error")
    }, onCompleted: {
        print("onCompleted")
    }, onDisposed: {
        print("onDisposed")
    })
    

sub1.dispose() //   이방식보다




var disposeBag = DisposeBag()


Observable.from([1, 2, 3])
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)


// 리소스를 해제할때는 새로운 DisposeBag을 넣던가 nil 을 할당하면 리소스가 해제된다.
disposeBag = DisposeBag()




let subscription2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe(onNext: {element in
        print("Next", element)
    }, onError: { error in
        print("error")
    }, onCompleted: {
        print("onCompleted")
    }, onDisposed: {
        print("onDisposed")
    })


DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    subscription2.dispose()
}

// 직접 dispose 한순간부터 메모리에서 해제 되기때문에 Completed 이벤트가 전달되지 않는다.
// 직접 메모리 해제 호출하는건 하지 않는게 좋다.
