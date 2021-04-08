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
import Action
import NSObject_Rx

class ActionViewController: UIViewController {
    
    @IBOutlet weak var runButton: UIButton!
    
    @IBOutlet weak var enabledSwitch: UISwitch!
    
    lazy var loginAction: Action<String, Bool> = Action { str in
        // loginRequest returns an Observable<Bool>
        print(str)
        
        return Observable.just(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        enabledSwitch.rx.value
        //            .bind(to: runButton.rx.isEnabled)
        //            .disposed(by: rx.disposeBag)
        
        
//        let buttonActon = Action<Void, Void> { (_) -> Observable<Void> in
//            print("doing some work")
//            return Observable.empty()
//        }
//
//        runButton.rx.action = buttonActon

        
        
//        let tt = Observable.combineLatest(Observable.just("Hello"), Observable.just("kiwan"))
        
        
        runButton.rx.tap
            .map({
                "asdf"
            })
            .bind(to: loginAction.inputs)
            .disposed(by: rx.disposeBag)
        
        
        
//        loginAction.elements
//            .subscribe {
//                print("ASdf")
//            }
//            .disposed(by: rx.disposeBag)
        
//        runButton.rx.tap
//            .bind(to: loginAction.input)
        
        
//            .disposed(by: bag)
        
        
    }
    
    //    func action
}
