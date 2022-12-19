//
//  ExampleView.swift
//  FirstSwiftUIApp
//
//  Created by 소연 on 2022/12/19.
//

import SwiftUI

struct ExampleView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.title)
                .foregroundColor(Color.green)
                .fontWeight(.ultraLight)
            Spacer()
            Text("I'm SO KYTE")
                .font(.subheadline)
                .italic()
            Spacer()
            Circle()
                .fill(.orange)
            Ellipse()
                .fill(.black)
            Image(systemName: "star.fill")
                .imageScale(.large)
                .foregroundColor(.red)
            Rectangle()
                .fill(.yellow)
            Spacer()
            Text("안녕하시렵니까\n안녕하다고\n안녕하다니까?")
                .underline()
                .strikethrough()
                .lineLimit(2)
                .kerning(8)
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
            .previewDevice("iPhone 11")
    }
}
