import SwiftUI

struct ContentView: View {
    @State private var currentDate = Date()
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var alertShown = false // 얼럿이 띄워진 적 있는지 상태 저장
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("현재 시간: \(formattedDate(currentDate))")
            Text("선택된 시간: \(formattedDate(selectedDate))")
            
            DatePicker("시간 선택", selection: $selectedDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .onChange(of: selectedDate) {
                    checkTimeEquality()
                }
        }
        .padding()
        .onReceive(timer) { _ in
            self.currentDate = Date()
            checkTimeEquality()
            
        }
        .alert(isPresented: $showAlert) { // true일때 알람표시
            Alert(title: Text("알림"), message: Text("선택한 시간이 현재 시간과 같습니다!"), dismissButton: .default(Text("확인")))
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func checkTimeEquality() {
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.hour, .minute], from: Date())
        let selectedComponents = calendar.dateComponents([.hour, .minute], from: selectedDate)
        
        if currentComponents == selectedComponents && !alertShown {
            showAlert = true // 일치 -> 얼럿 띄움, 상태 저장
            alertShown = true
        } else if currentComponents != selectedComponents {
            alertShown = false // 상태 리셋      
        }
    }
}

#Preview {
    ContentView()
}

