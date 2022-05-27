//
//  GetRecApp.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/1/22.
//

import SwiftUI

@main
struct GetRecApp: SwiftUI.App {
    var network = Network()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
