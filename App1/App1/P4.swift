//
//  P4.swift
//  App1
//
//  Created by Viktor Kirillov on 11/21/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI

struct P4: View {
    @State var flipFlop = false
    let timer = Timer.publish(every: 0.9, on: .current, in: .common).autoconnect()
    
    var body: some View {
//        Circles(flipFlop: flipFlop)
//        .frame(width: 100, height: 100)
//        .onReceive(timer) { _ in
//            self.flipFlop.toggle()
//        }
        
        Rectangle()
            .stroke(Color.black, style: StrokeStyle(
            lineWidth: 5, lineCap: .butt, lineJoin: .round,
            dash: [10, 10], dashPhase: flipFlop ? 0 : 40))
            .frame(width: 300, height: 300)
            .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false).speed(4))
            .onAppear() { self.flipFlop.toggle() }
        
    }
}

struct P4_Previews: PreviewProvider {
    static var previews: some View {
        P4()
    }
}

struct Circles: View {
    var flipFlop: Bool

    var body: some View {
        ZStack {
            Circle().fill(Color.green)
            Circle().fill(Color.yellow)
                .scaleEffect(0.8)
            Circle().fill(Color.orange)
                .scaleEffect(0.6)
            Circle().fill(Color.red)
                .scaleEffect(0.4)
        }
        .scaleEffect(flipFlop ? 0.2 : 0.8)
        .opacity(flipFlop ? 0.1 : 1.0)
        .animation(Animation.spring()
                    .repeatForever(autoreverses: true))
    }
}
