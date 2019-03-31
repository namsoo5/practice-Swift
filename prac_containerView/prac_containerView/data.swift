//
//  data.swift
//  prac_containerView
//
//  Created by 남수김 on 19/03/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

class Data1 {
    static let shared: Data1 = Data1()
    var textdata: String!
}
let DidReceiveFriendsNotification: Notification.Name = Notification.Name("DidRecieveFriends")

func request()  {
    //정보를 보내줌
    NotificationCenter.default.post(name: DidReceiveFriendsNotification, object: nil, userInfo: nil)
    //백그라운드에서 노티피케이션 발생시 백그라운드에서 작업하므로 table reload시 주의
    
}
