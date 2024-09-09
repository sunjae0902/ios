//
//  ContentView.swift
//  datePicker
//
//  Created by sunjae on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    @State var currentTime = Date()
    @State var selectedTime = Date()
    @State var selectedTimeString = ""
    @State var bgColor: Color?
    
    var body: some View {
        VStack {
            Text("현재 시간: \(currentTime, formatter: dateFormatter)").onAppear(perform:
                updateCurrentTime)
            DatePicker("날짜 선택", selection: $selectedTime) // binding 값에 접근 : '$'사용
                .onChange(of: selectedTime) {
                    print(selectedTime)
                   checkIfSameTime()
                }
                .datePickerStyle(GraphicalDatePickerStyle()) // 스타일 지정 가능 (Wheel, Graphical 등)
                .environment(\.locale, Locale(identifier: "ko_KR"))
                .padding()
            Text("선택 시간: \(selectedTime, formatter: dateFormatter)")
        }
        .padding().background(bgColor).ignoresSafeArea()
    }
    
    func updateCurrentTime() {
           Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
               currentTime = Date() // 현재 시간을 업데이트
               checkIfSameTime()
           }
       }
    
    func checkIfSameTime(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if(formatter.string(from: currentTime) == formatter.string(from: selectedTime)){
            bgColor = Color.red
        }else{
            bgColor = Color.white
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
              formatter.locale = Locale(identifier: "ko_KR") // 한국어 Locale 설정
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
             
              return formatter
    }
}

#Preview {
    ContentView()
}
