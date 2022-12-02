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


class RxCocoaTableViewViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let priceFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = NumberFormatter.Style.currency
        f.locale = Locale(identifier: "Ko_kr")
        
        return f
    }()
    
    let bag = DisposeBag()
    
//    var nameList = appleProducts.map { $0.name }
//    var productList = appleProducts
    
    var nameList = Observable<[String]>.just(appleProducts.map({ $0.name }))
    var productList = Observable<[Product]>.just(appleProducts)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // first
//        nameList
//            .bind(to: listTableView.rx.items) { (tableView, row, element) in
//                let cell = tableView.dequeueReusableCell(withIdentifier: "standardCell")!
//                cell.textLabel?.text = element
//                return cell
//            }
//            .disposed(by: bag)
        
        
        // second
//        nameList
//            .bind(to: listTableView.rx.items(cellIdentifier: "standardCell", cellType: UITableViewCell.self)) { (row, element, cell) in
//                cell.textLabel?.text = "\(element) @ row \(row)"
//            }
//            .disposed(by: bag)
        
        // Custom Cell
        
        productList
                    .bind(to: listTableView.rx.items(cellIdentifier: "productCell", cellType: ProductTableViewCell.self)) {
                        [unowned self] (row, element, cell) in
                        cell.categoryLabel.text = element.category
                        cell.productNameLabel.text = element.name
                        cell.summaryLabel.text = element.summary
                        cell.priceLabel.text = priceFormatter.string(for: element.price)
                        
                    }
                    .disposed(by: bag)
                
        Observable.zip(listTableView.rx.modelSelected(Product.self), listTableView.rx.itemSelected)
            .subscribe(onNext: { [weak self] (product, indexPath) in
                print(product.name)
                self?.listTableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: bag)
        
//        listTableView.delegate = self
        
        listTableView.rx.setDelegate(self)
            .disposed(by: bag)
        
    }
}


extension RxCocoaTableViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DidSelect")
    }
}

extension RxCocoaTableViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
