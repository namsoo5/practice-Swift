//
//  LocalChatService.swift
//  prac_Socket
//
//  Created by 남수김 on 2019/12/14.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Alamofire

class LocalChatService {
    private init() {}
    
    static let shared = LocalChatService()
    
    func getMemoList(id: String, completion: @escaping (ChatListModel) -> Void){
        
        let url = APIBase.getChatListAPI+id
        
        Alamofire.request(url).responseJSON{
            response in
            
            switch response.result{
            case .success:
                
                guard let data = response.data else {return}
                
                do{
                    let decoder = JSONDecoder()
                    print("alamo")
                    let object = try decoder.decode([ChatListModel].self, from: data)
                    
                    completion(object[0])
                    
                }catch(let err){
                    print(err.localizedDescription)
                    
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
