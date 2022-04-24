//
//  ClosetView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/20/22.
//

import SwiftUI

struct ClosetView: View {
    
    @ObservedObject var CC: ClosetController
    @Binding var selectedTab: Int
    @State var warning = false
    
    init(CC: ClosetController, selectedTab: Binding<Int>) {
        self.CC = CC
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Closet")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Click one of the clothing types below to view your clothes")
                    .frame(width:300)
                    .padding()
                    .multilineTextAlignment(.center)
                Group {
                    NavigationLink(destination: TypeView(CC:CC, type: "Hats")) {
                        Text("Hats")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
                            .padding(5)
                    }
                    NavigationLink(destination: TypeView(CC:CC, type: "Jackets")) {
                        Text("Jackets")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
                            .padding(5)
                    }
                    NavigationLink(destination: TypeView(CC:CC, type: "Tops")) {
                        Text("Tops")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
                            .padding(5)
                    }
                    NavigationLink(destination: TypeView(CC:CC, type: "Bottoms")) {
                        Text("Bottoms")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
                            .padding(5)
                    }
                    NavigationLink(destination: TypeView(CC:CC, type: "Shoes")) {
                        Text("Shoes")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
                            .padding(5)
                    }
                }
                Spacer()
                Button {
                    warning = true
                } label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 20))
                        Text("Clear Closet")
                            .font(.headline)
                    }
                }
                .alert(isPresented: $warning) {
                    Alert(
                        title: Text("Are you sure you want to clear your closet?"),
                        message: Text("You cannot undo this action"),
                        primaryButton: .destructive(Text("Clear")) {
                            CC.clearCloset()
                        },
                        secondaryButton: .cancel()
                    )
                }
                Spacer()
                    .frame(height:30)
            }
        }
    }
}
