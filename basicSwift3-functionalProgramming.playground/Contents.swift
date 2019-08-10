import UIKit

//클로저
//보통방식
func compareWord(first: String, second: String) -> Bool {
    return first > second
}
let sample = ["a","b","c","d"]
let reverse = sample.sorted(by: compareWord(first:second:))
//선행클로저
let reverse2 = sample.sorted(by: { (first: String, second: String)->Bool in
    return first>second
})
//후행클로저
var reverse3 = sample.sorted { (first: String, second: String)->Bool in
    return first>second
}
//생략하기
reverse3 = sample.sorted { (first, second) in
    return first>second
}
//단축 인자 이름
let reverse4 = sample.sorted { return $0 > $1 }
//암시적 반환 표현
let reverse5 = sample.sorted { $0 > $1 }
let reverse7 = sample.sorted(by: >)
//print(reverse7)
//클로저는 참조타입

//탈출 클로저
typealias VoidVoidClosure = ()->Void
func functionEscapingClosure(completion: @escaping VoidVoidClosure)->VoidVoidClosure{
    return completion
}
class SomeClass{
    var x = 10
    func runEscaping() -> VoidVoidClosure {
        return functionEscapingClosure {
            self.x = 100
        }
    }
}
let instance = SomeClass()
let returnClosure = instance.runEscaping()
returnClosure() //x값 변경
//print(instance.x)

//map
let mapNum = [0,1,2,3,4,5]
var doubleMapNum1 = mapNum.map({(num:Int) -> Int in
    return num*2
})
//간단하게
var doubleMapNum2 = mapNum.map({ num in
    return num*2
})
//매개변수 및 반환 타입 생략
var doubleMapNum3 = mapNum.map({ return $0 * 2 })
//반환 키워드생략
var doubleMapNum4 = mapNum.map({ $0 * 2 })
//후행
var doubleMapNum5 = mapNum.map{ $0 * 2 }
//print(doubleMapNum)

//filter
let evenNum = mapNum.filter{ return $0 % 2 == 0}
//print(evenNum)

//reduce
let reduceNum = [1,2,3]
let sumReduce = reduceNum.reduce(3, { (result: Int, element: Int)->Int in
  return result + element
})
let sumReduce2 = reduceNum.reduce(3) { $0 + $1 }

//고차함수 예제
enum Gender {
    case man, woman, non
}
struct Friend {
    let name: String
    let gender: Gender
    let age: Int
}
var friends = [Friend(name: "a", gender: .man, age: 19),
               Friend(name: "b", gender: .woman, age: 19),
               Friend(name: "c", gender: .woman, age: 22),
               Friend(name: "d", gender: .man, age: 22),
               Friend(name: "e", gender: .non, age: 24),
               Friend(name: "f", gender: .man, age: 24),
               Friend(name: "g", gender: .non, age: 25)]
var upTwentyTwo = friends.filter{ $0.age >= 22 && $0.gender != .non}
let result = upTwentyTwo.reduce("22세이상이고 성별확인된 사람들"){"\($0) \n \($1.name)"}

//모나드
//함수객체의 일종, 맵함수를 적용할 수 있는, 맵함수를 지원하는 컨테이너 타입
//값이 있을수도있고 없을 수도 있는 컨텍스트를 갖는 함수객체 타입
let optionalArr: [Int?] = [1,2,nil,5]
let mapped = optionalArr.map{ $0 }
//flat deprecated -> compactMap
let flatmapped = optionalArr.compactMap{ $0 }
//print(mapped)  //[Optional(1), Optional(2), nil, Optional(5)]
//print(flatmapped)  // [1, 2, 5]

