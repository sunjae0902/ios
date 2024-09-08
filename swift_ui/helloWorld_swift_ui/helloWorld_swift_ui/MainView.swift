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
    @State private var nickname: String = ""
    @State private var intro: String = ""
    
    var body: some View {
        VStack{
            Text("프로필 설정")
                .font(.titleMedium).padding([.bottom], 50)
            Image("icon/icon_profile").resizable().frame(width: 105,height: 105).padding(.bottom, 50)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("닉네임")
                    .font(.bodyMedium).foregroundColor(.gray)
                    .padding(.leading, 16)
                HStack{
                    TextField("사용할 닉네임을 설정해주세요.", text: $nickname).font(.titleSmall)   .padding(.bottom, 8).background(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                        .background(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        ).padding(.horizontal, 16)
                    Spacer()
                    Button(action: {}) {
                        Text("중복확인")
                            .foregroundColor(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }
                    .padding(.trailing, 16)
                }
                Text("2-10자, 띄어쓰기 및 특수문자 불가")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
            }
           
            VStack(alignment: .leading, spacing: 8) {
                Text("자기소개")
                    .font(.bodyMedium).foregroundColor(.gray)
                    .padding(EdgeInsets(top: 40, leading: 16, bottom: 0, trailing: 0))
                
                TextField("짧은 문장으로 본인을 소개해보세요.", text: $intro)
                    .font(.titleSmall).padding(.bottom, 8).background(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
                    .background(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    ).padding(.horizontal, 16)
                HStack {
                    Spacer()
                    Text("\(intro.count)/30")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                }
            }
            Spacer()
            Button(action: {
                print(nickname)
                print(intro)
            }) {
                Text("가입 완료")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(nickname.isEmpty || intro.isEmpty ? Color(UIColor.systemGray4) : Color.blue)
                    .cornerRadius(8)
            }
            .padding(16)
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
        MainView()
        // ImageView()
    }
}

