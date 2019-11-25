//
//  P7.swift
//  App1
//
//  Created by Viktor Kirillov on 11/21/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI

struct Joke: Codable {
    var id: String
    var joke: String
    var status: Int
}

func getJoke() {
    let url = URL(string: "https://icanhazdadjoke.com/")!
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("text/plain", forHTTPHeaderField: "Accept")
    
    let request = URLSession.shared.dataTaskPublisher(for: urlRequest)
        .map { $0.data }
        .replaceError(with: nil)
        .eraseToAnyPublisher()
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { joke in
            if let joke = joke,
                let strJoke = String(bytes: joke, encoding: .utf8) {
                    print(strJoke)
            }
        })
}

struct P7: View {
    @State private var jokes:[Joke] = []
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                getJoke()
            }
    }
}

struct P7_Previews: PreviewProvider {
    static var previews: some View {
        P7()
    }
}
