//
//  ListView.swift
//  FirstSwiftUIApp
//
//  Created by 소연 on 2022/12/19.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List { // TableView
            Text("1위")
            Text("2위")
            Text("3위")
            Text("4위")
            Text("5위")
                .foregroundColor(.yellow)
                .background(.black)
            Text("1위")
                .font(.caption) // 뷰 설정 우선
            Text("2위")
            
            Text("3위")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.red)
                .padding(.leading)
            Text("4위")
//            Text("5위")
            // -> 10개까지 가능
            
            ForEach(0..<50) {
                Text("List Cell \($0)")
            }
        }
        .listStyle(.plain) // 리스트 속성 지정
        .font(.largeTitle)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
