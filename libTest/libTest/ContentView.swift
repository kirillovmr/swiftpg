//
//  ContentView.swift
//  libTest
//
//  Created by Viktor Kirillov on 11/22/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI
import SocketIO

class Client {
    let manager: SocketManager
    let socket: SocketIOClient
    
    init() {
        manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        socket.connect()
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("currentAmount") {data, ack in
            guard let cur = data[0] as? Double else { return }
            
            self.socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                self.socket.emit("update", ["amount": cur + 2.50])
            }

            ack.with("Got your currentAmount", "dude")
        }
    }
}

struct ContentView: View {
    
    var client = Client()
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
