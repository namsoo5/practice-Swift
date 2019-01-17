import UIKit

let age = 7
if age < 3 {
    print("if : baby")
}else if age>=3 && age<20{
    print("if : child")
}else{
    print("if : adult")
}

switch age {
case 0,1,2:
    print("s1: baby")
case 3...19:
    print("s1: child")
default:
    print("s1: adult")
}

let tuple = (1,1)
switch tuple {
case (0, 0):
    print("s2: \(tuple) is at the origin")
case (_, 0):
    print("s2: \(tuple) is at the x-axis")
case (-2...2, -2...2):
    print("s2: \(tuple) is inside the box")
default:
    print("s2: ...")
}

let point = (2,2)
switch point {
case (let x, 0):
    print("s3: on the x-axis x value of \(x)")
case let(x,y):
    print("s3: x value of \(x), y value of \(y)")
default:
    print("s3...")
}

switch point {
case let (x,y) where x == y:
    print("s4: \(x), \(y) is on the line x == y")
default:
    print("s4: ...")
}


