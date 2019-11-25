//
//  ContentView.swift
//  SwiftUI Demo
//
//  Created by Viktor Kirillov on 11/18/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var landmark: Landmark
    
    var body: some View {
        VStack {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)
                .edgesIgnoringSafeArea(.top)
            
            CircleImage(image: landmark.image)
                .offset(x: 0, y: -160)
                .padding(.bottom, -160)
            
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                HStack {
                    Text(landmark.park).font(.subheadline)
                    Spacer()
                    Text(landmark.state)
                }
            }.padding()
            
            Spacer()
        }
        .navigationBarTitle(Text(landmark.name), displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(landmark: landmarkData[0])
    }
}
