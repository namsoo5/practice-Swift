import UIKit

//서브스크립트
struct Student {
    var name: String
    var number: Int
}
class School {
    var number: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String) {
        let student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    
    func addStudents(names: String...) {
        for name in names {
            self.addStudent(name: name)
        }
    }
    
    subscript(index: Int) -> Student? {
        get{
            if index < self.number {
                return self.students[index]
            }
            return nil
        }
        
        set{
            guard var newStudent = newValue else{ return }
            var number = index
            if index > self.number {
                number = self.number
                self.number += 1
            }
            
            newStudent.number = number
            self.students[number] = newStudent
            
        }
    }
    subscript(name: String) -> Void {
        let exist = self.students.filter{ $0.name == name }
        print(exist)
        
    }
}

let highSchool = School()
highSchool.addStudents(names: "a","b","c")
//print(highSchool.students)
let aStudent = highSchool[0]
//print(aStudent)
highSchool[0] = Student(name: "d", number: 0)
//print(highSchool[0].map{"\($0.name), \($0.number)"})
//highSchool["d"]

class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    required init(){
        print("요구 이니셜라이저")
        self.name = "Unknown"
        self.age = 0
    }
}
class Student1: Person {
    var major: String = "hi"
    
    init(name: String, age: Int, major: String){
        self.major = major
        super.init(name: name, age: age)   //슈퍼클레스 생성자호출
    }

    convenience init(name: String){
        self.init(name: name, age: 7, major: "")
    }
    
    required init() {
        print("부모의 요구 이니셜라이저")
        super.init()
    }
}
//자식클래스에서(Student1) 프로퍼티기본값을 모두 제공한다고하면 (major의 기본값이 존재하면)
//별도로 이니셜라이저를 구현하지 않았다면 이니셜라이저가 자동으로 상속됨

//타입케스팅
func checkType(item: Any){
    switch item {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let (x,y) as (Double,Double):
        print("an (x, y) point at \(x), \(y)")
    case let student as Student1:
        print("student! \(student.name)")
    default:
        print("what...")
    }
}
//checkType(item: 0)
//checkType(item: 0.0)
//checkType(item: (3.0, 4.0))
//checkType(item: Student1())

//프로토콜
@objc protocol Moveable {
    func walk()
    @objc optional func fly()  //optional적용하려면 @objc필요
}
class Tiger: Moveable{
    func walk() {
        print("tiger walks")
    }
}
class Bird: Moveable{
    func walk() {
        print("bird walks")
    }
    func fly() {
        print("bird flys")
    }
}

//extension
//상속: 수직확장, 재정의가능
//extension: 수평확장, 재정의 불가, 모든타입사용가능

//제네릭
struct NoGenericStack { // int형에만 적용 가능
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    mutating func pop() -> Int{
        return items.removeLast()
    }
}

struct GenericStack<Element> {  //모든 타입 적용가능
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
}
extension GenericStack {
    var topElement: Element? {
        return self.items.last
    }
}

//잘못된함수!! 무엇이 들어올지모르는데 -연산을함
//func subTwoValue<T>(_ a: T, _ b: T) -> T {
//    return a - b
//}

//타입 제약주기
func subTwoValue<T: BinaryInteger>(_ a: T, _ b: T) -> T {
    return a - b
}

protocol NamsProtocol {
    associatedtype NamsType  //제네릭같이 원하는 타입으로 바꿔 쓸 수 있음
    var count: NamsType { get }
    func countFunc()
}
protocol NamsProtocol1 {
    associatedtype NamsType  //제네릭같이 원하는 타입으로 바꿔 쓸 수 있음
    var number: NamsType { get }
    func numberFunc()
}
struct NamsTest: NamsProtocol, NamsProtocol1 {
    var count: Int
    var number: Int
    func countFunc() {
        print(count)
    }
//    방법2 - 명시적으로 표시해주기
//    typealias NamsType = Int
//    var count: NamsType
}
extension NamsProtocol where Self: NamsProtocol1 {
    func numberFunc(){
        print("nams1")
    }
}
let nam = NamsTest(count: 10, number: 20)
nam.numberFunc()

let items = [1,2,3,4].map{$0}
