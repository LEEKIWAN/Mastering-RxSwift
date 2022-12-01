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
 # refCount
 */
// ConnectableObservable은 단 하나의 시퀀스만 만들어지기때문에 시퀀스를 다시 만들 수 없다. -> connect 하는 시점..
// refCount는 내부적으로 connectable로 관리하다가 구독하는 시점에 Connect 해서 시퀀스를 자동으로 만든다.
// 구독자가 없으면 Disconnect 해서 자동으로 시퀀스를 종료한다.

// 장점은 앞서 본 연산자들은 connect disconnect를 매뉴얼로 관리해야하지만 refCount는 connect, Disconnect를 자동으로 관리해줘서 리소스 관리에 수월하다.

let bag = DisposeBag()
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().publish().refCount()

let observer1 = source
    .subscribe { print("🔵", $0) }

//source.connect()

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    observer1.dispose()
}


DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
    let observer2 = source.subscribe { print("🔴", $0) }

    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
        observer2.dispose()
    }
}

