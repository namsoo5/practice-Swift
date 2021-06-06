import UIKit

class ins {
    var a = 1
    
    func simpleAdd() {
        self.a += 1
//        print("simpleAdd")
    }
    
    func simpleMul() {
        self.a *= 2
//        print("simpleMul")
    }
}
let one = ins()

let test = DispatchQueue(label: "a", qos: .default, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)


DispatchQueue.global().async {
    for _ in 0..<10 {
        one.simpleAdd()
        print("add: \(one.a)")
    }
}
test.async {
    for _ in 0..<10 {
        print("test")
    }
}
print("------")
DispatchQueue.global().async {
    for _ in 0..<10 {
        one.simpleMul()
        print("mul: \(one.a)")
    }
}

