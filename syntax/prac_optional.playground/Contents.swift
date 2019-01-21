import UIKit

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

print(convertedNumber)  // 숫자가아닌 문자가포함된다면 nil값이들어올수있음 -> optional    결과:Optional(123)
print(convertedNumber!) //optional unwrap    결과:123

if convertedNumber != nil{
    print("not nil \(convertedNumber!)")  //강제로 옵셔널벗겼을때 닐값이면 죽어버림주의
}

if let actualNumber = Int(possibleNumber){   //optional binding
    print(actualNumber)
}  //아래의코드를 간략하게

/*
 let convertedNumber = Int(possibleNumber)
 if convertedNumber != nil{
 print("not nil \(convertedNumber!)")  //강제로 옵셔널벗겼을때 닐값이면 죽어버림주의
 }
 */

