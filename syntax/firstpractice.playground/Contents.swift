import UIKit

var str = "Hello, playground"

var version = 20
let ver = 10
var version2 : Double = 3

print(type(of: version))
print("version is \(version) and version2 is \(version2)")

var str1 = "hi, playground. \nnice to meet you"
print(str1)
var str2 = """
hi, playground.
nice to meet you
"""
print(str2)

var emptystr = ""
var another = String()

if emptystr.isEmpty{
    print("비어있습니다.")
}
let string1 = "there"
let string2 = "over"
var welcome = string2 + string1
print(welcome)   //overthere
print(welcome.count)  //9

var emptyArray = Array<String>()
var emptyArray2 = [String]()

print(emptyArray)  // []

emptyArray2.append("A")
emptyArray2.append("B")
print(emptyArray2) // A B

var emptyArray3 = ["A", "B", "C"]
print(emptyArray3)   // A B C

emptyArray3 += ["D", "F"]
print(emptyArray3)   // A B C D F
print(emptyArray3[3])  // D

emptyArray3[3] = "Z"
print(emptyArray3)  // A B C Z F

emptyArray3[0...2] = ["AA", "BB", "CC"]
print(emptyArray3)  // AA BB CC Z F
print(emptyArray3.count)  // 5

//immutable array
let emptyArray4 = ["A", "B", "C"]
print(emptyArray4)  // A B C
// error     emptyArray4[0] = "g"

