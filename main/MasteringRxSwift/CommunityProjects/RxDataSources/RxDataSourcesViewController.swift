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
import RxDataSources
import Action




class RxDataSourcesViewController: UIViewController {
    let viewModel = RxDataSourcesViewModel()
    
    @IBOutlet weak var addButton: UIButton!

    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        addButton.rx.tap
            .bind(to: viewModel.input.buttonAction)
            .disposed(by: rx.disposeBag)
        
        // 섹션 타이틀
        viewModel.dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }
        
        
        //오른쪽 인디케이터 문자와 인덱스참조가능
        viewModel.dataSource.sectionForSectionIndexTitle = { ds, title, index in
            print(title)
            print(index)
            return ds.sectionModels.map { $0.header }.firstIndex(of: title) ?? 0
        }

        
           
        viewModel.dataSource.sectionIndexTitles = { ds in return ds.sectionModels.map { $0.header } }

        
        viewModel.output.tableViewDatas
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
        
//        viewModel.output.tableViewDatas.asDriver()
//            .drive(tableView.rx.items(dataSource: viewModel.dataSource))
//            .disposed(by: rx.disposeBag)
        
//        viewModel.output.tableViewDatas
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: rx.disposeBag)
        
        
  
     
//
//        (TableViewSectionedDataSource<Section>) -> [String]
    }
}




class CustomCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
}
