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
 # generate
 */

// range 는 1씩 증가하는 정수만 가능하다.
// generate는 range에서 불가능한 부분을 가능하게 한다. -> 커스터마이징가능함.. 정수뿐아니라 문자열도 가능하다.


let disposeBag = DisposeBag()
let red = "🔴"
let blue = "🔵"


Observable<Int>.generate(initialState: 0, condition: {
    return $0 <= 10
}, iterate: {
    return $0 + 3
})
.subscribe({
    print($0)
})
.disposed(by: disposeBag)



Observable<String>.generate(initialState: red, condition: {
    return $0.count < 14
}, iterate: {
    let last = $0.last!
    if String(last) == red {
        return $0 + blue
    } else {
        return $0 + red
    }
})
.subscribe({
    print($0)
})
.disposed(by: disposeBag)
