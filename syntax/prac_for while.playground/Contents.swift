import UIKit

var age = 0
while age < 5 {
    age += 1
    print("while: \(age)")
}

let names = ["A","B","C","D","F"]

for name in names{
    print("eng : \(name)")
}

let numberOfLegs = ["ant":6, "snake":0, "cheetah":4]
for (name, leg) in numberOfLegs {
    print("\(name) have \(leg)legs")
}

for index in 1...5{
    print("\(index) index")
}

for _ in 1...5{  //변수 굳이필요없을경우
    print("hi")
}

let minutes = 5
for count in 0..<minutes{
    print("count: \(count)")
}

let minuteInterval = 5
for count in stride(from: 0, to: minutes, by: minuteInterval){
    print("stride: \(count)")  //마지막숫자 포함안됨
}
for count in stride(from: 0, through: minutes, by: minuteInterval){
    print("stride_through: \(count)")  //마지막숫자 포함
}

