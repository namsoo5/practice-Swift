import UIKit

//중첩데이터타입
struct A{
    var b: B
    enum C{
        case ac
    }
}
struct B{
    var c: C
    enum C {
        case bc
    }
}
let a: A.C = .ac
let b: B.C = .bc


let (x,y,z) = (1,2,3)
//print(x)
let points = [(0,0),(0,3),(1,2),(2,1)]
for (x, _) in points{
    if x == 0 {
//        print("x는 0!")
    }
}

//값 바인딩
let someValue: Any = 100

//switch  someValue {
//case is String:
//    print("String~")
//case let value as Int:
//    print("Int~ \(value)")
//default:
//    print("what...")
//}


//where 절
let tuples: [(Int, Int)] = [(1,2),(-1,-2),(2,2),(0,3)]
//for tuple in tuples {
//    switch tuple {
//    case let (x, y) where x == y:
//        print("x == y")
//    case let (x, y) where x > y:
//        print("x > y")
//    case (0, _):
//        print("x=0")
//    default:
//        print("what...?")
//    }
//}

//옵셔널 패턴과 where 활용
let optionalInt: [Int?] = [nil, 1, 2 ,nil, 5]
//for case let number? in optionalInt where number > 1 {
//    print(number)
//}

protocol P1 {
    var a: Int { get }
}
protocol P2 {
    var b: Int { get }
}
protocol P3 {
    var b: Int { get }
}
class Limit: P1, P2{
    var a: Int = 1
    var b: Int = 2
}
extension P1 where Self: P2 {
    func justPrint(){
        print("p1, p2프로토콜 모두를 준수하는 타입!")
    }
}
extension P1 where Self: P3 {
    func justPrint(){
        print("p1, p3프로토콜 모두를 준수하는 타입!")
    }
}
//let justClass = Limit()
//justClass.justPrint()
var ref: Limit?
func neverEnd(){
    let a = Limit()    //참조횟수: 1
    ref = a    //참조횟수 2
    
    //함수종료
    //참조횟수 1
}
//class RoomType {
//    var special: Bool?
//    var room: Room?
//}
class RoomType {
    var special: Bool?
    var room: Room?
    init(_ s: Bool) {
        self.special = s
    }
}

class Room {
    var number: Int?
    var roomType: RoomType?
    init() {
        number = 1
    }
}

var room: Room? = Room()    //Room 참조횟수1
var type: RoomType? = RoomType(true)    //RoomType 참조횟수1
room?.roomType = type    //RoomType 참조횟수2
type?.room = room    //Room 참조횟수2
//type?.room = room    //Room 참조횟수1
//type?.room = nil    //Room 참조횟수1
room = nil    //Room 참조횟수0
//type = nil    //RoomType 참조횟수1
//print(type?.room?.number)

//획득목록 capture list
class Person {
    let name: String
    
    lazy var myNameIs: () -> String = {
        return "my name is \(self.name)"
    }
    
    init(_ n: String) {
        self.name = n
    }
    
    deinit {
//        print("deinit!!")
    }
}

var people: Person? = Person("player")
//print(people?.myNameIs())
people = nil
//Optional("my name is player")   ->  강한참조 순환문제

class Person2 {
    let name: String
    
    lazy var myNameIs: () -> String = { [unowned self] in
        return "my name is \(self.name)"
    }
    
    init(_ n: String) {
        self.name = n
    }
    
    deinit {
//        print("deinit!!")
    }
}

var people2: Person2? = Person2("player")
//print(people2?.myNameIs())
people2 = nil
//Optional("my name is player")
//deinit!!

//defer
//오류를 던지기 직전까지 작성된 defer구문 까지만 실행됨
//여러개의 구문이 하나의 범위내부에 속해있다면 아래부터 위로 역순으로 실행됨
func someThrowing(err: Bool) throws -> Int {
    defer {
        print("first")
    }
    if err {
        enum SomeErr: Error {
            case justErr
        }
        
        throw SomeErr.justErr
    }
    defer {
        print("second")
    }
    defer {
        print("third")
    }
    return 100
}
//try? someThrowing(err: true)
//first
//try? someThrowing(err: false)
//third
//second
//first

func someFunc() {
    print("1")
    
    defer {
        print("2")
    }
    
    do {
        defer {
            print("3")
        }
        print("4")
    }
    
    defer {
        print("5")
    }
    print("6")
}
//someFunc()
//1
//4
//3
//6
//5
//2

//실행파일 이름, 코드실행되는 줄수
//print("\(#file), \(#line)")

//#if swift(>=4)
//print("swift4이상 환경에서 빌드")
//#endif

if #available(iOS 11, *) {
    print("ios 11이상 버전에서 실행중 입니다.")
}
@available(swift, introduced: 4.0)  //이 변수는 스위프트4.0이상에서 사용 할 수 있습니다.
var swift4 = "swift4.0"
