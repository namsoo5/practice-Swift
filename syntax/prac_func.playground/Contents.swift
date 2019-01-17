import UIKit

func sayHello(){
    print("1: hello")
}
sayHello()

func sayHello2(name:String){
    print("2: hello \(name)")
}
sayHello2(name: "Kim")

func sayHello3(name:String) -> String{
    return "3: Hello " + name
}
print(sayHello3(name: "Kim"))

func sayHello4(name:String = "Kim"){
    print("4: Hello \(name)")
}
sayHello4(name:"kim~")

//내부사용: name  외부에서사용(argument): insertYourName
func sayHello5(insertYourName name:String, internationalAge age:Int){
    print("Hello \(name) is \(age) year old")
}
sayHello5(insertYourName: "Kim", internationalAge: 20)

func sayHello6(_ name:String, _ age:Int) -> String{   //return Type = string
    return "Hello \(name) is \(age) year old"
}
print(sayHello6("Kim", 22))
