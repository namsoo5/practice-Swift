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

struct ThirdContent: View {
    var body: some View {
        ZStack{
        
            AngularGradient(gradient: Gradient(colors: [.red,.orange,.yellow,.green,.blue,.purple]), center: .center).edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text("11시")
                    Spacer()
                    Text("12시")
                    Spacer()
                    Text("11시")
                }
                Spacer()
                HStack{
                    Text("9시")
                    Spacer()
                    Text("중앙")
                    Spacer()
                    Text("3시")
                }
                Spacer()
                HStack{
                    Text("7시")
                    Spacer()
                    Text("6시")
                    Spacer()
                    Text("5시")
                }
            }
            
            
            
            
            /*
            Color.yellow.edgesIgnoringSafeArea(.all)
            RadialGradient(gradient: Gradient(colors:[.white, .black]), center: .center, startRadius: 310, endRadius: 100)
            AngularGradient(gradient: Gradient(colors:[.red,.yellow,.blue]), center: .center)
            Color.red.frame(width:300,height: 300)
            Color(red: 0.1, green: 0.2, blue: 0.3).frame(width:00,height:2000)
            Color.blue.frame(width:100,height: 100)
            
            
            Color.yellow.edgesIgnoringSafeArea(.all)  //SafeArea 영역무시
            Color.red.frame(width: 300, height: 300)
            Color.blue.frame(width:200,height: 200)
            
            VStack(alignment: .leading, spacing: 20){
                Text("hello123")
                Spacer().frame(height: 5)
                Text("hello")
                //            Spacer().frame(width: 5)
                Text("hello")
                
                
                HStack(alignment: .center, spacing: 20){
                    Text("hi123")
                    Spacer()
                    Text("hi")
                    Spacer()
                    Text("hi")
                }.background(Color.gray)
                
            }
            */
        }
    }
}

struct ContentView_Preview3: PreviewProvider {
    static var previews: some View {
        ThirdContent()
    }
}


//struct ContentView_Preview2: PreviewProvider {
//    static var previews: some View {
//        SecondContent()
//    }
//}
//
//struct ContentView_Previews1: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
