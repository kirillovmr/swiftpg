//
//  P8.swift
//  App1
//
//  Created by Viktor Kirillov on 11/21/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI
import WebKit

struct WebViewPage: UIViewRepresentable {
    let theURL: String
    init(_ url: String = "https://www.apple.com") {
        self.theURL = url
    }
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiview: WKWebView, context: Context) {
        if let url = URL(string: theURL) {
            let request = URLRequest(url: url)
            uiview.load(request)
        }
    }
}

struct P8: View {
    var body: some View {
        WebViewPage()
    }
}

struct P8_Previews: PreviewProvider {
    static var previews: some View {
        P8()
    }
}
