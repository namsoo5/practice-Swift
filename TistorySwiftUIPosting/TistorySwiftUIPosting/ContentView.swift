//
//  ContentView.swift
//  TistorySwiftUIPosting
//
//  Created by 남수김 on 2021/03/15.
//

import SwiftUI

class TimerCount: ObservableObject {
    @Published private(set) var count: Int = 0
    
    init() {
        print(#function)
    }
    
    func plus() {
        count += 1
    }
}

struct TestView: View {
    @State private var isUpdate: Bool = false
    @ObservedObject var viewModel = TimerCount()
    var body: some View {
        VStack {
            CountView(timer: viewModel)
                .background(isUpdate ? Color.red : Color.orange)
            Divider()
            Button("update") {
                isUpdate.toggle()
            }
        }
    }
}

struct CountView: View {
//    @StateObject var timer: TimerCount
    @ObservedObject var timer: TimerCount
    
    var body: some View {
        VStack {
            Text("\(timer.count)")
            Button("plus") {
                timer.plus()
            }
        }
    }
}

struct ContentView: View {
    var arr: [Name] = [Name(id: "1", a: "1"),Name(id: "2", a: "2")]
    var body: some View {
        VStack {
            ZStack {
                List {
                    ForEach([1,2,3,4], id: \.self) {
                        Text("\($0)")
                    }.onDelete(perform: { indexSet in
                        print(indexSet)
                    })
                }
            }
//            ForEach(arr, id: \.self) { index in
//
//            }
//            Color.blue.frame(width: 50, height: 50)
//            Color.red.frame(width: 100, height: 100)
//            PickerTest()
        }
//        .background(Color.gray)
    }
}

struct LongText: View {
    var body: some View {
        ZStack {
            ZStack {
                Color.black
                VStack {
                    Spacer()
                    ZStack {
                        Color.red
                        VStack {
                            HStack {
                                Color.blue
                            }
                            Spacer().frame(height: 20)
                            ScrollView {
                                Text("o\no\no\no\no\no\no\no\no\no\no\no\no\no\no\no\no\no\no\no\no\no\no\ndddddddddddddddddfdfdfdfdfdfdfdfdf123")
                            }
                        }
                    }.frame(height: 290)
                }
            }
        }
    }
}

struct ListTest: View {
    var body: some View {
        VStack {
            Text("Hello")
            Text("Hello")
            Text("Hello")
            List {
                Text("List")
                Text("List")
                Text("List")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ListTest().frame(height: 400)
        }
    }
}

struct Name: Identifiable, Hashable {
    let id: String
    let a: String
}

struct PickerTest: View {
    @State private var selectNum: Int? = 1
    @State private var isOn: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Picker("골라골라", selection: $selectNum) {
                    Text("고르기 포기").tag(Int?.none)
                    ForEach([nil, -2,-1,0,1,2,3,4,5,6], id: \.self) { num in
                        Text("\(num ?? -1)").tag(num)
                    }
                }
                Toggle(isOn: $isOn) {
                    Text("on")
                }
            }
        }
    }
}

