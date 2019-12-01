//
//  ContentView.swift
//  prac_FirstSwiftUI
//
//  Created by 남수김 on 2019/11/29.
//  Copyright © 2019 ns. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var name = ""
    
    var body: some View {
        NavigationView{
            
            VStack {
                Form{
                    Text("Form Text")
                }.navigationBarTitle("NavigationTitle")
                
                
                Text("Hello World3")
                Text("Hello World4")
                Button(action: {}) {
                    Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                }
                
                Form{
                    Section{
                        Text("Hello World1")
                        Text("Hello World2")
                    }
                    Section{
                        Text("당신의 이름은?")
                        Text("아래에 입력해주세요!!")
                    }
                    Section{
                        TextField("이름은?", text: $name)
                            .keyboardType(.default)
                    }
                    Section{
                        Text("나의이름은 \(name)")
                    }
                }
                
                
            }
        }
        
    }
    
}

struct SecondContent: View{
    
    let genderType = ["남성","여성","비밀"]
    @State var name = ""
    @State var bornIn = 0
    @State var gender = 0
    
    var resultScript:String{
      if(name.isEmpty){
        return "이름을 입력해주세요."
      }else{
        return "\(name)님은 성별이 \(genderType[gender])이며 나이는 \(120 - bornIn)입니다."
      }
    }

    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("이름")){
                    TextField("이름을 입력해주세요", text: $name)
                        .keyboardType(.default) //키보드를 기본 키보드로 보여줍니다.
                }
                
                Section(header: Text("생년월일")){
                    //선택하는 값을 bornIn 변수에 할당합니다.
                    Picker("출생년도",selection: $bornIn){
                        // 1900부터 2018까지 Text를 만듭니다.
                        ForEach(1900 ..< 2019 ){
                            Text("\(String($0))년생")
                        }
                    }
                    
                    
                }
                
                Section(header: Text("성별")){
                    //선택하는 값을 bornIn 변수에 할당합니다.
                    Picker("성별",selection: $gender){
                        // 1900부터 2018까지 Text를 만듭니다.
                        ForEach( 0  ..< genderType.count ){
                            Text("\(self.genderType[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("결과")){
                  Text("\(resultScript)")
                }
            }.navigationBarTitle("회원가입")
        }
    }
}

struct ContentView_Preview2: PreviewProvider {
    static var previews: some View {
        SecondContent()
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
