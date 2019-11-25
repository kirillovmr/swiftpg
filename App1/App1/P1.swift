//
//  P1.swift
//  App1
//
//  Created by Viktor Kirillov on 11/20/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI

struct v2: View {
    var body: some View {
        NavigationView {
          List {
            Section(header: Text("Section One")) {
              ForEach(0..<3) { index in
                NavigationLink(destination: Text("Item \(index)")){
                  Text("Section item \(index)")
                }
              }
            }
            Section(header: Text("Section Two")) {
              ForEach(50..<55) { index in
                NavigationLink(destination: Text("Area \(index)")){
                  Text("Restricted Area \(index)")
                }
              }
            }
          }.navigationBarTitle(Text("Applications"))
        }
    }
}

struct mview: View {
    var body: some View {
        TabView{
           Text("First Controller View")
            .tabItem({
                Image(systemName: "person")
            })
           Text("Second Controller View")
            .tabItem({
                Image(systemName: "square")
            })
            Text("Third Controller View")
            .tabItem({
                Image(systemName: "text.justify")
            })
        }
    }
}

struct P1: View {
    var name2 = "Boris"
    @State var click = true
    @State var name = "Unknown"
    
    @State var gameMode = 0
    var modes = ["Easy", "Difficult", "Insane"]
    var shadowColor : Color {
        switch gameMode {
        case 1:
            return Color.yellow
        case 2:
            return Color.red
        default:
            return Color.green
        }
    }
    
    var body: some View {
        VStack {
            Image("turtlerock").resizable().scaledToFit()
            
            HStack {
                Text("Enter your name: ")
                TextField("", text: $name) {}
            }.padding()
        
            HStack {
                Text("Hello, \(click ? name : name2)")
                    .font(.title)
                    .shadow(color: shadowColor, radius: 5)
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .overlay(
                        Image(systemName: "star")
                            .foregroundColor(.orange))
            }
            NavigationView {
                NavigationLink("Go to next view", destination: mview())
                    .navigationBarTitle("Haha")
            }
            
            Toggle(isOn: $click) {
                Text("Toggle name")
            }.padding()
            
            Picker("Mode", selection: $gameMode, content: {
               ForEach(0..<modes.count) { index in
                   Text(self.modes[index])
                   .tag(index)
               }
            })
        }
    }
}

struct P1_Previews: PreviewProvider {
    static var previews: some View {
        P1()
    }
}
