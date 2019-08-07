import UIKit

//함수형 프로그래밍
func sum(first: Int) -> ((Int) -> Int) {
    return { second in first+second }
}
//print(sum(first: 10))
func excute(tasks: [() -> Void]){
    for task in tasks {
        task()
    }
}
func excuteAll() {
    hello()
    hi()
}
func hello() {
//    print("hello")
}
func hi() {
//    print("hi")
}

//함수형 프로그래밍
excute(tasks: [hello, hi])
//명령형 프로그래밍
excuteAll()

//튜플
var person: (n :String, a: Int) = ("hi", 3)

//배열
var name = ["yagom", "chulsoo", "younghee", "yagom"]
name[2] = "jenny"

name.append("elsa")
name.append(contentsOf: ["john", "max"])
//print(name)

//딕셔너리
typealias StringIntDic = [String: Int]
var numberForName: StringIntDic = StringIntDic()
numberForName = ["a":1, "b":2]
numberForName["c"] = 3
//print(numberForName)

//세트
var NameSet: Set<String> = ["a", "b", "c"]
var NumSet: Set<String> = ["1","2","3"]
let unionSet = NameSet.union(NumSet)
//print(unionSet)

//열거형
enum WeekDays: Character{
    case mon = "월"
    case tue = "화"
    case wed = "수"
    case thu = "목"
    case fri = "금"
    case sat = "토"
    case sun = "일"
}
let today: WeekDays = .wed
//print("오늘은 \(today.rawValue)")
enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case rice
}
var dinner: MainDish = MainDish.pasta(taste: "크림")
//print(dinner)
func cook(_ value: MainDish) -> String{
    switch value {
    case .pasta(let tast):
        return tast+"파스타"
    case .pizza(let dough, let topping):
        return dough+"와 "+topping+" 추가한 피자"
    case .rice:
        return "rice"
    }
}
//print(cook(dinner))

//가변 매개변수
func addValue(num: Int...){
    for n in num {
//        print(n)
    }
}
addValue(num: 3,4,5)
addValue(num: 1,2)

//inout 매개변수
var originNum = [1,2,3]
func nonRef(_ arr: [Int]){
    var temp = arr
    temp[0] = 10
}
func ref(_ arr: inout[Int]){
    arr[0] = 10
}
nonRef(originNum)
//print(originNum)
ref(&originNum)
//print(originNum)


//함수 타입사용
typealias CalculateTwoInt = (Int, Int) -> Int
func add(_ a: Int, _ b: Int)->Int{
    return a+b
}
func multi(_ a: Int, _ b: Int)->Int{
    return a*b
}
var math: CalculateTwoInt = add
//print(math(1,2))
math = multi
//print(math(2,3))

//함수반환
func printMathResult(_ math: CalculateTwoInt, _ a: Int, _ b: Int){
//    print("result: \(math(a,b))")
}
printMathResult(math, 10, 2)

//옵셔널
var opt: String? = "hi"
//switch opt {
//case .none:
//    print("nil")
//case .some(let a):
//    print(a)
//    print(opt)
//}

