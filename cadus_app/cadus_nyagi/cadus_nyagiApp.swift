//
//  cadus_nyagiApp.swift
//  cadus_nyagi
//
//  Created by Emmett Easter on 2/24/23.
//

import SwiftUI

@main
struct cadus_nyagiApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(bodyOptions())
        }
    }
}
