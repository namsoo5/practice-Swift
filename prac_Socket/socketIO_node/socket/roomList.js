const userList = [
    {
        "id": "1",
        "name": "ns",
        "isConneted": false
    },
    {
        "id": "2",
        "name": "jm",
        "isConneted": false
    },
    {
        "id": "3",
        "name": "jh",
        "isConneted": false
    },
    {
        "id": "4",
        "name": "hj",
        "isConneted": false
    }
]

const chatRoom = [
    {
        'name': '1',
        'room': ["test", "b", "c"]
    },
    {
        'name': '2',
        'room': ["d", "b", "c"]
    }
]

module.exports = (name) => {
  const list = []
  
  chatRoom.forEach(element => {
    if( element.name == name ){
      list.push(element)
    }
  }); 
    return list
}