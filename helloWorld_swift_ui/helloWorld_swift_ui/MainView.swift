//
//  MainView.swift
//  helloWorld_swift_ui
//
//  Created by sunjae on 8/20/24.
//

import SwiftUI

struct MainView: View {
    @State private var signedUp = false // @State:구조체 내부에서 변경 가능한 값 -> Binding과 자주 사용

    var body: some View {
        Group { // 논리적 개념, 조건부 뷰 표시 가능
            if signedUp {
                ContentView(logOutAction: {
                    self.signedUp = false
                })
            } else {
                LoginView(logInAction: {
                    self.signedUp = true
                })
            }
        }
    }
}

struct ContentView: View {
    let logOutAction: () -> Void // 로그아웃 액션 함수 파라미터로 전달

    var body: some View {
        VStack {
            Text("Welcome to the Main Content!")
                .font(.largeTitle)
                .padding()

            Button(action: logOutAction) {
                Text("Log Out")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
    }
}

struct LoginView: View {
    let logInAction: () -> Void // 로그인 액션 함수를 파라미터로 전달

    var body: some View {
        VStack{
            Text("프로필 설정")
                .font(.titleMedium).padding(20)
            Image("icon/icon_profile").resizable().frame(width: 105,height: 105)
            Button(action: logInAction) {
                Text("가입하기")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
        }
    }
}

struct ImageView: View {
    var body: some View {
        
        VStack {
            HStack {
                Image("icon/image_cat").resizable().aspectRatio(contentMode: .fit).clipShape(Circle()).shadow(radius: 4, x: 5, y:10).onTapGesture {
                    print("Tap: This is image")
                }
                Image(systemName: "cat.circle").resizable().frame(width:70, height:70).foregroundColor( .blue)
                Image("icon/image_cat").resizable().clipShape(Rectangle()).overlay(Rectangle().stroke(Color.purple, lineWidth: 4.0))
                Image("icon/image_cat").resizable().clipShape(RoundedRectangle(cornerRadius: 50))
            }
        }
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
       // MainView()
        ImageView()
    }
}

