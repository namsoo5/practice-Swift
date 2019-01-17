import UIKit

var name = ["Park", "Kim", "Lee"]
var age = [3, 4, 5]
var height = [100, 110, 120]

print(name[0], age[0], height[0])

//위의 코드를간단하게
struct Student{
    var name:String
    var age:Int
    var height:Int
}

var student1 = Student(name: "Park", age: 3, height: 100)

print(student1.name, student1.age, student1.height)
