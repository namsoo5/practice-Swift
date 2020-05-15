	
var helloWorld = "Hello World! from file"

function getFullname(firstname, lastname) {
    return firstname + " " + lastname;
}


function generateLuckyNumbers() {
    var luckyNumbers = [];
 
    while (luckyNumbers.length != 6) {
        var randomNumber = Math.floor((Math.random() * 50) + 1);
 
        if (!luckyNumbers.includes(randomNumber)) {
            luckyNumbers.push(randomNumber);
        }
    }
    handleLuckyNumbers(luckyNumbers);
}


var labelCount = 3
var UIElements = ["Label", "Alert"]
var alert = {style: "alert", title: "알림"}
var label1 = {x: 0, y: 0, width: 200, height: 50, text: "테스트1"}
var label2 = {x: 0, y: 100, width: 200, height: 50, text: "테스트2"}
var label3 = {x: 0, y: 200, width: 200, height: 50, text: "테스트3"}



