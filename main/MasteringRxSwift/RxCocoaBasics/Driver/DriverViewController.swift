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
import RxCocoa



// Driver 는 데이터를 UI 바인딩하는 연산자 그래서 메인스레드 실행된다.
// Driver는 시퀀스를 공유한다.

// SharedSequence Type 으로 바뀐다. share(replay: 1, scope: .whileConnected)

// 에러처리에도 용이하다. 왜?


enum ValidationError: Error {
    case notANumber
}

class DriverViewController: UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let result = inputField.rx.text.asDriver()
            .flatMapLatest {
                validateText($0)
                    .asDriver(onErrorJustReturn: false)
            }
            
//            .flatMapLatest {
//                validate($0)
//            }
            
            
        
        	
        
        
        result
            .map { $0 ? "Ok" : "Error" }
            .drive(resultLabel.rx.text)
            .disposed(by: bag)
        
        result
            .map { $0 ? UIColor.blue : UIColor.red }
            .drive(resultLabel.rx.backgroundColor)
            .disposed(by: self.bag)
        
        //
        result
            .drive(sendButton.rx.isEnabled)
            .disposed(by: bag)
        
    }
}


func validateText(_ value: String?) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
        print("== \(value ?? "") Sequence Start ==")
        
        defer {
            print("== \(value ?? "") Sequence End ==")
        }
        
        guard let str = value, let _ = Double(str) else {
            observer.onError(ValidationError.notANumber)
            return Disposables.create()
        }
        
        observer.onNext(true)
        observer.onCompleted()
        
        return Disposables.create()
    }
}
