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


class RxCocoaTableViewViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let priceFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = NumberFormatter.Style.currency
        f.locale = Locale(identifier: "Ko_kr")
        
        return f
    }()
    
    let bag = DisposeBag()
    
    let nameObservable = Observable.of(appleProducts.map({
        $0.name
    }))
    
    let productObservable = Observable.of(appleProducts)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // #1 standard Cell
        
//        nameObservable.bind(to: listTableView.rx.items) { (tableView, row, element) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "standardCell")!
//            cell.textLabel?.text = element
//            return cell
//        }
//        .disposed(by: bag)
        
        
        // #2 -  #1을 개선 - Basic type 이기때문에 거의 안쓰인다. 실무적으로

//        nameObservable.bind(to: listTableView.rx.items(cellIdentifier: "standardCell")) { row, element, cell in
//            cell.textLabel?.text = element
//        }
//        .disposed(by: bag)
        
        
        // #3 - Custom Cell 을 만들어보자
        
        productObservable.bind(to: listTableView.rx.items(cellIdentifier: "productCell", cellType: ProductTableViewCell.self)) { [weak self] row, element, cell in
            cell.categoryLabel.text = element.category
            cell.productNameLabel.text = element.name
            cell.summaryLabel.text = element.summary
            
            cell.priceLabel.text = self?.priceFormatter.string(for: element.price)
        }
        .disposed(by: bag)
        
        
//        listTableView.rx.itemSelected.subscribe {
//            productObservable.ele $0.row
//        }
        
    }
}




