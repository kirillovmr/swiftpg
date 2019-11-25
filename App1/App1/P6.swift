//
//  P6.swift
//  App1
//
//  Created by Viktor Kirillov on 11/21/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI

import UIKit
import MapKit

struct P6: View {
    @State private var coords =
        CLLocationCoordinate2D(latitude: -37.8177131, longitude: 144.9679939)
    
    var body: some View {
        MapView(coords: $coords)
    }
}

struct P6_Previews: PreviewProvider {
    static var previews: some View {
        P6()
    }
}


struct MapView: UIViewRepresentable {
    @Binding var coords: CLLocationCoordinate2D
    typealias MyContext = UIViewRepresentableContext <MapView>
  
    func makeUIView(context: MyContext) -> MKMapView {
        return MKMapView(frame: .zero)
    }
  
    func updateUIView(_ view: MKMapView, context: MyContext) {
        let coordinate = CLLocationCoordinate2D(latitude: coords.latitude, longitude: coords.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}
