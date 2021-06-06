//
//  main.swift
//  swiftSyntax
//
//  Created by 남수김 on 2020/03/13.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation

// MARK: 배열
let array = [1,2,3]
print(array)
// [1, 2, 3]
var tempArray = array
tempArray.append(4)
print(array)
// [1, 2, 3]

// MARK: 딕셔너리
let dictionary = [1:1, 2:2, 3:3]
print(dictionary)
// [2: 2, 3: 3, 1: 1]
var tempDic = dictionary
tempDic[4] = 4
print(dictionary)
// [2: 2, 3: 3, 1: 1]

// MARK: class
class Room {
    var size: Int
    init(size: Int) {
        self.size = size
    }
    func room() {
        print("\(size)크기의 Room")
    }
}
let roomClass = Room(size: 1)
let tempClass = roomClass
tempClass.size = 2
print(roomClass.size)
//2
//클래스는 참조타입!
roomClass.room()
//2크기의 Room

struct Coffee {
    let water: Int
    var ice: Int
}
//에러 - let 구조체 변경불가
//let coffee = Coffee(water: 10, ice: 10)
//coffee.water = 20
//coffee.ice = 20

var coffee = Coffee(water: 10, ice: 10)
//에러 - let 변경불가
//coffee.water = 20
coffee.ice = 20
print(coffee)
//Coffee(water: 10, ice: 20)
var tempCoffee = coffee
tempCoffee.ice = 30
print(coffee)
//Coffee(water: 10, ice: 20)
//구조체는 값타입!

class Hotel: Room {
    let roomNum = 10
    override func room() {
        print("\(size)크기의 Hotel")
    }
}

let hotel = Hotel(size: 10)
hotel.room()
//10크기의 Hotel
let hotelRoom = hotel as Room
hotelRoom.room()
//10크기의 Hotel

protocol Product {
    var price: Int {get set}
}

protocol MacBook: Product {
    var macNum: Int{get set}
}

protocol iPhone: Product {
    var iPhoneNum: Int{get set}
}

struct Apple: MacBook, iPhone {
    var macNum: Int
    var iPhoneNum: Int
    var price: Int
}
// protocol은 채택가능
// 상속과 채택은 다른개념

enum Color {
    case red, blue, green
}
enum Orientation {
    case left, right
}
struct Attribute: Hashable {
    var color: Color
    var orientation: Orientation
}
let blueLeft = Attribute(color: .blue, orientation: .left)
let blueRight = Attribute(color: .blue, orientation: .right)
var cache = [blueLeft: "왼쪽"]
cache[blueRight] = "오른쪽"
let value = cache[blueLeft]
print(value)
//Optional("왼쪽")

// MARK: ** String 문법 **

var someString = "abcdef"
var numString = "1234"
// MARK: for문시 String으로 형변환후 문자열합치기가능
for s in someString {
    numString += String(s)
}
print(numString)
//1234abcdef

print("\n*****************")
// MARK: indices를 쓰는경우 배열인덱스를 사용하듯이 접근가능
for index in someString.indices {
    print(someString[index])
//    print(someString[0]) 불가능
}

print("\n*****************")
// MARK: 문자열 인덱스가져오기
let startIndex = someString.startIndex
let endIndex = someString.endIndex
print(someString[startIndex])
//a

//print(someString[endIndex])
//err

print(someString[startIndex..<endIndex])
//abcdef

let secondIndex = someString.index(startIndex, offsetBy: 1)    // 0 + 1 번째
print(someString[secondIndex])
//b
let newSomeString1 = someString[startIndex..<secondIndex]
let newSomeString2 = someString[secondIndex..<endIndex]
print(newSomeString1 + ", " + newSomeString2)
//a, bcdef

print((someString as NSString).range(of: "ab"))
//{0,2}

// MARK: split -> substrin: String으로 형변환후 문자열합치기가능
let someSplit = someString.split(separator: "c")
//let addSplit = someSplit[0]+someString[1]
//substring 문자열 못합침
let addSplit = someSplit.reduce(""){$0 + $1}
print(someSplit)
print(addSplit)
//["ab", "def"]
//abdef

// MARK: 문자열 배열로 변환하기
let someCharArray = Array(someString)
//someString.map{String($0)}
print(someCharArray)
//["a", "b", "c", "d", "e", "f"]

// MARK: split -> String 배열만드기
numString = "1,2,3,4,5"
let stringToInt = numString.components(separatedBy: ",").map{Int($0)!}
print(stringToInt)
//[1, 2, 3, 4, 5]

// MARK: ascii코드
let tempChar = "A"
let asciiNum = (UnicodeScalar(tempChar)?.value)!
let tempInt = 97
let asciiChar = UnicodeScalar(tempInt)!
print(asciiNum)
//65
print(asciiChar)
//a

// MARK: 접두,접미사
someString = "abcdef"
print(someString.suffix(3))    // 접미사
//def
print(someString.prefix(2))    // 접두사
//ab


// MARK:
