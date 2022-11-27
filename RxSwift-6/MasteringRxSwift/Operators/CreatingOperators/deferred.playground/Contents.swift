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
 # deferred
 */

let disposeBag = DisposeBag()
let animals = ["🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐯"]
let fruits = ["🍎", "🍐", "🍋", "🍇", "🍈", "🍓", "🍑"]
var flag = true





let ob = Observable<[String]>.deferred {
    flag.toggle()
    if flag {
        return Observable.just(animals)
    } else {
        return Observable.just(fruits)
    }
}


ob.subscribe({
    print($0)
})

ob.subscribe({
    print($0)
})

ob.subscribe({
    print($0)
})


let create = Observable<[String]>.create {
    flag.toggle()

    if flag {
        $0.onNext(animals)
    } else {
        $0.onNext(fruits)
    }

//    $0.onCompleted()
    return Disposables.create()
}

create.subscribe({
    print($0)
})


create.subscribe({
    print($0)
})

create.subscribe({
    print($0)
})
