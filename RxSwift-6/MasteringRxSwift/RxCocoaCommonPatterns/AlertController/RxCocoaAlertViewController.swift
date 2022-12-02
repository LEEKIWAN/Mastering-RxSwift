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

class RxCocoaAlertViewController: UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var oneActionAlertButton: UIButton!
    
    @IBOutlet weak var twoActionsAlertButton: UIButton!
    
    @IBOutlet weak var actionSheetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneActionAlertButton.rx.tap
            .flatMap({ [unowned self] in info(title: "Coloddddr") })
            .subscribe(onNext: { [unowned self] in
                switch $0 {
                case .ok:
                    print(colorView.backgroundColor?.rgbHexString ?? "dd")
                default:
                    print("dd")
                }
            })
            .disposed(by: bag)
        
        
        twoActionsAlertButton.rx.tap
            .flatMap { [unowned self] in alert(title: "Alerttttt") }
            .subscribe(onNext: {
                switch $0 {
                case .ok:
                    print("ok")
                case .cancel:
                    print("cancel")
                }
            })
            .disposed(by: bag)
     
        actionSheetButton.rx.tap
            .flatMap({ [unowned self] in chooseColor(colors: MaterialBlue.allColors, title: "Choose The Color") })
            .subscribe(onNext: { [unowned self] in
                colorView.backgroundColor = $0
            })
            .disposed(by: bag)
    }
}

enum ActionType {
    case ok
    case cancel
}


extension UIViewController {
    
    func info(title: String, contents: String? = nil) -> Observable<ActionType> {
        return Observable<ActionType>.create { [unowned self] observer in
            let alert = UIAlertController(title: title, message: contents, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
            return Disposables.create {
                alert.dismiss(animated: true)
            }
        }
    }
    
    func alert(title: String, contents: String? = nil) -> Observable<ActionType> {
        return Observable<ActionType>.create { [unowned self] observer in
            let alert = UIAlertController(title: title, message: contents, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { _ in
                observer.onNext(.cancel)
                observer.onCompleted()
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            
            return Disposables.create {
                alert.dismiss(animated: true)
            }
        }
    }
    
    
    func chooseColor(colors: [UIColor], title: String, contents: String? = nil) -> Observable<UIColor> {
        return Observable<UIColor>.create { [unowned self] observer in
            let alert = UIAlertController(title: title, message: contents, preferredStyle: .actionSheet)
            
            for color in colors {
                let colorAction = UIAlertAction(title: color.rgbHexString, style: .default) { _ in
                    observer.onNext(color)
                    observer.onCompleted()
                }
                alert.addAction(colorAction)
            }
            
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { _ in
                observer.onCompleted()
            }
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
            
            return Disposables.create {
                alert.dismiss(animated: true)
            }
        }
    }
}
