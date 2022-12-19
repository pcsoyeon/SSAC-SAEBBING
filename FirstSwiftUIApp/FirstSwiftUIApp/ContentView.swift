//
//  ContentView.swift
//  FirstSwiftUIApp
//
//  Created by 소연 on 2022/12/19.
//

import SwiftUI // iOS13 + WWDC19

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .imageScale(.large)
                .foregroundColor(Color.pink)
            Text("안녕하세요")
        }
        .padding()
        .border(.red)
        .padding()
        .border(.green)
//        .frame(width: 400, height: 700)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
