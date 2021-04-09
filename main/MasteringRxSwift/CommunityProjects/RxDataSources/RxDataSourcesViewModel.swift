//
//  RxDataSourcesViewModel.swift
//  MasteringRxSwift
//
//  Created by kiwan on 2021/04/09.
//  Copyright © 2021 Keun young Kim. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import Action


struct MySection {
    var header: String
    var items: [String]
}

extension MySection: AnimatableSectionModelType {
    init(original: MySection, items: [String]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return header
    }
}




var sections = [
    MySection(header: "A", items: ["1", "2asfsdafadflsdahjfkdahfsd;ak fjlajdlfjla lks; fjlasd", "asdklfasdljkfjlsdkaj3"]),
    MySection(header: "B", items: ["4", "5"])
]

class RxDataSourcesViewModel: NSObject {
    
    
    struct Input {
        var buttonAction = PublishSubject<Void>()
    }
    
    struct Output {
        var tableViewDatas = BehaviorRelay<[MySection]>(value: sections)
    }
    
    let input = Input()
    
    let output = Output()
    
   
    
    override init() {
        super.init()
        
        
        input.buttonAction.bind(onNext: { [unowned self] in
            addAction()
        })
        .disposed(by: rx.disposeBag)
        

        
        
        
    }
    
    
    func addAction() {
        sections.append(MySection(header: "C", items: ["6", "7", "8"]))
        sections.append(MySection(header: "D", items: ["4", "5"]))
        output.tableViewDatas.accept(sections)
    }

    
}

