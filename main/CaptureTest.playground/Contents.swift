import UIKit

//var greeting = "Hello, playground"
//
//
//
//class Test {
//    
//    let t = 5
//    
//    
//    func go() {
//        DispatchQueue.main.async { [self] in
//            print(t)
//        }
//    }
//        
//    deinit {
//        print("deinit")
//    }
//}
//
//var val: Test? = Test()
//
//val?.go()
//
//val = nil
//
//print("Owari")
//
//



struct Human {
    var name = ""
    
    lazy var getName: () -> String = { [self] in
        return name
    }
    
    init(name: String) {
        self.name = name
    }
    
    func printName() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.name
        }
    }
 
//    deinit {
//        print("Human Deinit!")
//    }
}


var n: Human? = Human(name: "kiwan")


n?.getName

n = nil


print("owari")
