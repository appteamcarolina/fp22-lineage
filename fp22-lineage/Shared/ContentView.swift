//
//  ContentView.swift
//  Shared
//
//  Created by Jackson Dowden on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var CC = ClosetController()
    
    var body: some View {
        NavigationView {
            NewPictureView(CC:CC)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
