//
//  P3.swift
//  App1
//
//  Created by Viktor Kirillov on 11/21/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI

var todos = [
    "Lol"
]

struct P3: View {
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(0..<todos.count) { index in
                        ListItem(title: todos[index])
                    }
                }.navigationBarTitle("ToDo")
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<5) { index in
                        GeometryReader { g in
                            CoolImage().padding()
                                .rotationEffect(.degrees(
                                    Double(g.frame(in: .global).minX)
                                ))
                        }
                    }.frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct P3_Previews: PreviewProvider {
    static var previews: some View {
        P3()
    }
}

struct CircleView: View {
    var body: some View {
        Circle()
            .stroke(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom), lineWidth: 5)
            .frame(width: 200, height: 200)
            .padding()
    }
}

struct ListItem: View {
    @State private var selected: Bool = false
    var title: String = "untitled"
    
    var body: some View {
        HStack {
            Image(systemName: selected ?
                   "checkmark.square" : "square")
            Text("\(title)")
                .strikethrough(selected, color: .red)
        }.onTapGesture {
            self.selected.toggle()
        }
    }
}

struct CoolImage: View {
    var body: some View {
        Image(systemName: "cloud.sun.bolt.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .bottom, endPoint: .top) )
            .cornerRadius(30)
            .shadow(radius: 10)
    }
}
