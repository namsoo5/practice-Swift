import UIKit

var emptyDictionary = Dictionary<String, Int>()  //empty dictionary
var emptyDictionary2 = [String:Int]()  //empty dictionary

if emptyDictionary2.isEmpty{
    print("nothing")
}
print(emptyDictionary2)
emptyDictionary2["ant"] = 6
emptyDictionary2["snake"] = 0
print(emptyDictionary2.count)  //2
print(emptyDictionary2)  // ["ant": 6, "snake":0]

var emptyDictionary3 = ["ant":6, "snake":0, "cheetah":4]
emptyDictionary3["human"] = 2
emptyDictionary3["snake"] = 1
print(emptyDictionary3)

print(emptyDictionary3["cheetah"]!)  //optional

//immutable dictionary
let emptyDictionary4 = ["ant":6, "snake":0, "cheetah":4]
// error      emptyDictionary4["snake"] = 1

