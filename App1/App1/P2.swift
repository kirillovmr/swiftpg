//
//  P2.swift
//  App1
//
//  Created by Viktor Kirillov on 11/20/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI
import Combine

struct Seat: View {
    @State private var booked = false
    
    var body: some View {
        VStack {
            HStack {
              Text("Seat Status : ")
              Image(systemName: booked ? "xmark" : "checkmark")
                .foregroundColor(booked ? .red : .green)
            }
            .font(.largeTitle)
            
            BookButton(booked: $booked)
            
            AnotherView()
        }
    }
}

struct P2_Previews: PreviewProvider {
    static var previews: some View {
        Seat()
    }
}

struct BookButton: View {
    @Binding var booked: Bool
    
    var body: some View {
        Button(booked ? "Release" : "Book") {
            self.booked.toggle()
        }
    }
}

class BookingStore: ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    var bookingName: String = "" {
        didSet { updateUI() }
    }
    var seats: Int = 1 {
        didSet { updateUI() }
    }
    func updateUI() {
        objectWillChange.send()
    }
}

struct AnotherView: View {
    @ObservedObject var model = BookingStore()
    
    var body: some View {
        VStack {
            TextField("Your Name", text: $model.bookingName)
            Stepper("Seats : \(model.seats)",
                    value: $model.seats,
                    in: 1...5)
        }
    }
}
