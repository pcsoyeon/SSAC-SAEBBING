//
//  Tamagochi.swift
//  FirstSwiftUIApp
//
//  Created by 소연 on 2023/01/04.
//

import SwiftUI

// 멤버와이즈 이니셜라이저를 통해서 파라미터처럼 원하는 값을 지정할 수 있다.
struct GrowButton: View {
    var text: String
    var icon: Image
    var action: () -> Void
    
    var body: some View {
        Button(action: action , label: {
            icon
            Text(text)
        })
        .padding()
        .background(.black)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}

// Opaque Type (불투명 타입 = 역제너릭)
struct Tamagochi: View {
    
    @State var riceCount: Int = 0

    var body: some View {
        VStack(spacing: 10) {
            Text("방실방실 다마고치")
            Text("Lv 1. 밥알 \(riceCount)개 물방울 15개")
            GrowButton(text: "밥먹기", icon: Image(systemName: "star")) {
                riceCount += 1
            }
            GrowButton(text: "물먹기", icon: Image(systemName: "heart")) {
                print("물먹기 버튼을 눌렀어요.")
            }

        }
        // 프로퍼티 내부에서는 실제 타입이 어떤지 명확하게 알 수 있다.
    }
    // 프로퍼티 외부에서는 어떤 타입인지 알 수 없다.
}

// View -> immutable
struct CompytedProperty: View {
    @State var apple = "사과"
    
    var body: some View {
//        mutating get { // 문법적으로는 가능하지만, View 프로토콜의 문법적인 규약이 있기 때문에 불가
            Text(apple)
//        }
    }
}

struct User {
    var name = "고래밥"
    
    mutating func changeName() { // copy on write
        name = "사과"
    }
}

struct Tamagochi_Previews: PreviewProvider {
    static var previews: some View {
        Tamagochi()
    }
}
