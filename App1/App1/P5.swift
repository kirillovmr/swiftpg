//
//  P5.swift
//  App1
//
//  Created by Viktor Kirillov on 11/21/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI

struct P5: View {
    @State private var position: CGPoint = .zero
    @State private var angle = Angle.radians(0)
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.green.opacity(0.1))
                .frame(width: 320, height: 320)
            
            Image(systemName: "paperplane")
                .font(.largeTitle)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(x: self.position.x, y: self.position.y)
                .animation(Animation.spring())
                .rotationEffect(angle)
                .gesture(
                    DragGesture()
                    .onChanged { self.position = $0.location }
                    .onEnded { _ in
                        if sqrt(self.position.x * self.position.x +
                                self.position.y * self.position.y)
                           > 160 {
                            self.position = .zero
                        }
                    }
                )
                .gesture(
                    RotationGesture( minimumAngleDelta: Angle.degrees(1))
                    .onChanged { angle in
                        self.angle = angle
                        print("rot")
                    }
                    .onEnded { angle in
                        self.angle = Angle.radians(0)
                        print("Fin rot")
                    }
                )
        }
    }
}

struct P5_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            P5().previewDevice("iPhone X").previewDisplayName("iPhone X")
            P5().previewDevice("iPhone SE").previewDisplayName("iPhone SE")
        }
    }
}
