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
 # flatMap
 */
// InnerObservable
// ResultObservable -> InnerObservable을 합쳐서 하나의 옵저버블로 만들어주는 Observable
// Interleaving -> 순서가 뒤죽박죽...  나중에 Concat 이랑 비교해보자.
// flatten -> 하나로 만들어준다.

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redHeart = "❤️"
let greenHeart = "💚"
let blueHeart = "💙"


Observable<String>.from([redCircle, greenCircle, blueCircle])
    .flatMap({ circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable<String>.repeatElement(redHeart)
                .take(5)
        case greenCircle:
            return Observable<String>.repeatElement(greenHeart)
                .take(5)
        case blueCircle:
            return Observable<String>.repeatElement(blueHeart)
                .take(5)
        default:
            return Observable.just("")
        }
    })
    .subscribe({
        print($0)
    })
    .disposed(by: disposeBag)
