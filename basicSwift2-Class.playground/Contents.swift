import UIKit

//구조체
struct testStruct{
    var a:Int
    var b:Int
}
//구조체는 let으로 선언하면 프로퍼티 수정불가 var로 선언하면 수정가능
let st1 = testStruct(a: 1, b: 2)
//st1.a = 2
//print(st1)
var st2 = testStruct(a: 1, b: 2)
st2.a = 2
//print(st2)

//클레스
class testClass{
    init(_ a:Int, _ b:Int) {
        self.a = a
        self.b = b
    }
    var a:Int
    var b:Int
}
//class는 let으로 선언해도 프로퍼티 수정가능
let cl1 = testClass(1, 2)
//print(cl1.a)
cl1.a = 2
//print(cl1.a)

//클레스 구조체 차이
//구조체 상속불가
//타입캐스팅은 클래스의 인스턴스만가능
//구조체는 값타입 클래스는 참조타입

//연산 프로퍼티
struct CoordinatePoint{
    var x: Int //저장 프로퍼티
    var y: Int
    
    var oppositePoint: CoordinatePoint {  //연산 프로퍼티
        //접근자
        get {
            return CoordinatePoint(x: -x, y: -y)
        }
        //설정자
        set {
            x = -newValue.x
            y = -newValue.y
        }
    }
}
var position: CoordinatePoint = CoordinatePoint(x: 2, y: 3)
//print(position)
//print(position.oppositePoint)

//프로퍼티 감시자
class Account {
    var credit: Int = 0 {
        willSet { // 전달인자: 변경될 값
            print("잔액이 \(self.credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        didSet { //전달인자: 변경전 값
            print("잔액이 \(oldValue)원에서 \(self.credit)원으로 변경되었습니다.")
        }
    }
    
    var dollarValue: Double {
        get {
            return Double(credit/1000)
        }
        set {
            credit = Int(newValue * 1000)  //credit프로퍼티 감시자 호출
            print("잔액을 \(newValue)달러로 변경중 입니다")
        }
    }
}
let myAccount: Account = Account()
//myAccount.credit = 1000
//잔액이 0원에서 1000원으로 변경될 예정입니다.
//잔액이 0원에서 1000원으로 변경되었습니다.
class ForeginAccount: Account{
    override var dollarValue: Double {
        willSet {
            print("달러: 잔액이\(self.dollarValue)에서 \(newValue)달러로 변경될 예정입니다.")
        }
        didSet {
            print("달려: 잔액이\(oldValue)에서 \(self.dollarValue)달러로 변경 되었습니다.")
        }
    }
}
let myAccount1: ForeginAccount = ForeginAccount()
//myAccount1.dollarValue = 1
//달러: 잔액이0.0에서 1.0달러로 변경될 예정입니다.
//잔액이 0원에서 1000원으로 변경될 예정입니다.
//잔액이 0원에서 1000원으로 변경되었습니다.
//잔액을 1.0달러로 변경중 입니다
//달려: 잔액이0.0에서 1.0달러로 변경 되었습니다.

//mutating
//구조체나 열거형은 값타입이지만 mutating을 이용해서 인스턴스 메소드내의 프로퍼티를 변경할 수 있다
enum OnOffSwitch {
    case on, off
    mutating func next(){
        self = self == .on ? .off : .on
    }
}
var toggle: OnOffSwitch = OnOffSwitch.off
toggle.next()
//print(toggle)

class AClass {
    static func staticTypeMethod(){
        print("재정의불가")
    }
    class func classTypeMethod(){
        print("재정의가능")
    }
}
//AClass.staticTypeMethod()
//AClass.classTypeMethod()
class BClass: AClass{
    override class func classTypeMethod(){
        print("재정의!!")
    }
    subscript(value: Int, value2: Int) -> Int{
        get {
            return value + value2
        }
    }
}
//BClass.classTypeMethod()
let bclass = BClass()
//print(bclass[2,4])

