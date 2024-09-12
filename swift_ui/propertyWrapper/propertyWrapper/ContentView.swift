//
//  ContentView.swift
//  propertyWrapper
//
//  Created by sunjae on 9/12/24.
//

import SwiftUI

@propertyWrapper
struct Uppercase {
    private var value: String = ""

    var wrappedValue: String { // 값에 실제로 접근하여 가져오거나 쓸 수 있도록
        get { print("get"); return value } // getter (외부에서 value를 사용)
        set { print("set"); value = newValue.uppercased() } //setter(value에 값을 할당할 경우 호출됨)
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}


struct ContentView: View {
    @Uppercase var name = "kim"

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(name)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
