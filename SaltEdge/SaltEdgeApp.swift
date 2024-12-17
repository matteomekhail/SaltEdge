//
//  SaltEdgeApp.swift
//  SaltEdge
//
//  Created by Matteo Mekhail on 16/12/24.
//

import SwiftUI

@main
struct SaltEdgeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    // Handle the callback URL from Salt Edge
                    if url.scheme == "saltedge-app" {
                        // Process the callback
                        print("Received callback from Salt Edge:", url)
                    }
                }
        }
    }
}
