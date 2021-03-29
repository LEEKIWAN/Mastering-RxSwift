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
 # generate
 */

// range는 정수만을 방출하는 연산자인 반면 generate는 타입에 자유롭다.

let disposeBag = DisposeBag()
let red = "🔴"
let blue = "🔵"


// condition에 만족하지 않으면 바로 complete 을 방출하고 종료된다.
// iterate는 방출할 값을 지정한다.

Observable.generate(initialState: 0, condition: {
    $0 <= 10
}, iterate: {
    $0 + 2
})
.subscribe {
    print($0)
}
.disposed(by: disposeBag)


Observable<String>.generate(initialState: red) {
    $0.count < 15
} iterate: {
    if $0.count.isMultiple(of: 2) {
        return $0 + red
    }
    else {
        return $0 + blue
    }
}
.subscribe {
    print($0)
}
