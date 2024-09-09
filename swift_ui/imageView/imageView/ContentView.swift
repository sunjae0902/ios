//
//  ContentView.swift
//  imageView
//
//  Created by sunjae on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    let imagePath = ["1", "2", "3", "4"]
    @State var curIndex = 0
    var body: some View {
        VStack {
            Spacer()
            Image(imagePath[curIndex]).resizable().aspectRatio(contentMode: .fit)
            Spacer()
            HStack {
                Button("이전"){
                    if(curIndex == 0){
                        curIndex = 3
                    }else{
                        curIndex -= 1
                    }
                }.padding([.trailing], 100)
                Button("다음"){
                    if(curIndex == 3){
                        curIndex = 0
                    }else{
                        curIndex += 1
                    }
                    
                }
            }
        }.padding([.horizontal], 20)
    }
}

#Preview {
    ContentView()
}
