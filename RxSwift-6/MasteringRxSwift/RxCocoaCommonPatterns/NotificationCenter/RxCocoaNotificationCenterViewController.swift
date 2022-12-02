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
import RxCocoa

class RxCocoaNotificationCenterViewController: UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var toggleButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                if self.textView.isFirstResponder {
                    self.textView.resignFirstResponder()
                } else {
                    self.textView.becomeFirstResponder()
                }
            })
            .disposed(by: bag)
        
        
        
        
        let keyboardWillShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .map { notification in
                return (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }
        
        let keyboardWillHide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { _ in
                return CGFloat(0)
            }
        
        
        Observable<CGFloat>.merge([keyboardWillShow, keyboardWillHide])
            .subscribe(onNext: { [weak self] keyboardHeight in
                guard let self = self else { return }
                var inset = self.textView.contentInset
                inset.bottom = keyboardHeight
                
                var scrollInset = self.textView.scrollIndicatorInsets
                scrollInset.bottom = keyboardHeight
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.textView.contentInset = inset
                    self.textView.scrollIndicatorInsets = scrollInset
                })
            })
            .disposed(by: bag)
        
        
        
//        var inset = strongSelf.textView.contentInset
//        inset.bottom = height
//
//        var scrollInset = strongSelf.textView.scrollIndicatorInsets
//        scrollInset.bottom = height
//
//        UIView.animate(withDuration: 0.3, animations: {
//            strongSelf.textView.contentInset = inset
//            strongSelf.textView.scrollIndicatorInsets = scrollInset
//        })
//
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        }
    }
}
