//
//  ContentView.swift
//  tab
//
//  Created by sunjae on 9/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("first Item").tabItem {
                Image(systemName: "1.square.fill")
                Text("first")}
            ImageView().tabItem {
                Image(systemName: "2.square.fill")
                Text("second")}
            DatePickerView().tabItem {
                Image(systemName: "3.square.fill")
                Text("third")}
        }
    }
}

#Preview {
    ContentView()
}
