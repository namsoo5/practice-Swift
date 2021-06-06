//
//  ViewController.swift
//  prac_Realm
//
//  Created by 남수김 on 2020/09/17.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var realm: Realm!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createRealmFile()
    
        let notiToken = realm.observe { notification, realm in
            print(notification)
//            switch notification {
//            case .didChange:
//
//            case .refreshRequired
//            }
            print(realm)
        }
        // 추가
        let dog = add(name: "dog", age: 1)
        let dog2 = add(name: "dog", age: 1)
//        let cat = add(name: "cat", age: 5)
//        print(dog)
//        print(cat)

        // 변경
//        dog.age = 10 // err
        
        let myDog = realm.objects(Animal.self).filter("name == 'dog'").first
        let testDog = realm.objects(Animal.self).filter("name == 'dog'").first
//        print("myDog")
//        print(myDog)
//        let list = [myDog, testDog]
//        try! realm.write {
//            list[0]?.age = 100
//        }
        
        var list = realm.objects(Animal.self)
        print("삭제전")
        print(list)
        // 삭제
        try! realm.write {
            realm.delete(dog)
        }
        list = realm.objects(Animal.self)
        print("삭제후")
        print(list)
        
        
        
        
    }
    
    // MARK: - 파일생성
    func createRealmFile() {
        let config = setDefaultRealmForUser(fileName: "a")
        realm = try? Realm(configuration: config)
        print(realm?.configuration.fileURL)
        let path = realm?.configuration.fileURL?.deletingLastPathComponent().path
        print(path)
    }
    
    // MARK: - 파일설정
    func setDefaultRealmForUser(fileName: String) -> Realm.Configuration {
        var config = Realm.Configuration()

        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(fileName).realm")
        
        // Set this as the configuration used for the default Realm
        return config
    }
    
    func add(name: String, age: Int) -> Animal {
        let animal = Animal()
        animal.name = name
        animal.age = age
        
        try! realm.write {
            realm.add(animal)
        }
        
        return animal
    }
}

class Animal: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}

