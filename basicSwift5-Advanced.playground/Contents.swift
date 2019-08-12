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

