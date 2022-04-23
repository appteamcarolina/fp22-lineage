//
//  PictureSettingsView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/22/22.
//

import SwiftUI

struct PictureSettingsView: View {
    
    @State var needAvatar = false
    @State var needSelect = false
    @State var clothing: Clothing
    @State var selected: Bool = false
    @ObservedObject var CC: ClosetController
    var defaultLine = Line()
    @Binding var selectedTab: Int
    @State var allowNav = false
    
    init(CC: ClosetController, selectedTab: Binding<Int>) {
        defaultLine.points.append(CGPoint(x:0,y:0))
        defaultLine.points.append(CGPoint(x:420,y:0))
        defaultLine.points.append(CGPoint(x:420,y:560))
        defaultLine.points.append(CGPoint(x:0,y:560))
        self.CC = CC
        self._selectedTab = selectedTab
        self.clothing = Clothing()
    }
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Add Clothing to Closet")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(15)
                Spacer()
                    .frame(height:40)
                HStack {
                    Spacer()
                        .frame(width:30)
                    Menu {
                        Button {
                            clothing = clothing.updateType(type: "Hats")
                        } label: {
                            Text("Hat")
                        }
                        Button {
                            clothing = clothing.updateType(type: "Jackets")
                        } label: {
                            Text("Jacket")
                        }
                        Button {
                            clothing = clothing.updateType(type: "Tops")
                        } label: {
                            Text("Top")
                        }
                        Button {
                            clothing = clothing.updateType(type: "Bottoms")
                        } label: {
                            Text("Bottoms")
                        }
                        Button {
                            clothing = clothing.updateType(type: "Shoes")
                        } label: {
                            Text("Shoes")
                        }
                    } label: {
                        HStack {
                            Image(systemName: "tshirt")
                                .resizable()
                                .scaledToFit()
                                .frame(width:30, height:30)
                                .foregroundColor(Color.black)
                            Text("Tap to select what type of clothing")
                                .font(.headline)
                                .frame(width:170)
                                .foregroundColor(Color.black)
                        }
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                    }
                    Spacer()
                        .frame(width:40)
                    switch clothing.type {
                    case "Hats":
                        Text("Hat")
                    case "Jackets":
                        Text("Jacket")
                    case "Tops":
                        Text("Top")
                    case "Bottoms":
                        Text("Bottoms")
                    case "Shoes":
                        Text("Shoes")
                    default:
                        Text("None Selected")
                            .frame(width:90)
                    }
                    Spacer()
                }
                Text("When taking an image of an article of clothing we recommend wearing it and having it fill the frame as much as possible")
                    .multilineTextAlignment(.center)
                    .frame(width:350)
                    .padding(10)
                Text("Additionally, make sure you are standing in the same stance as in your avatar photo, and the camera is at the same angle")
                    .multilineTextAlignment(.center)
                    .frame(width:350)
                    .padding(10)
                Button {
                    if (!(CC.dummy.photoChosen)) {
                        needAvatar = true
                    } else if (clothing.type == "") {
                        needSelect = true
                    } else {
                        clothing = clothing.updatePhoto()
                    }
                } label: {
                    VStack {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width:30, height:30)
                            .foregroundColor(Color.black)
                        Text("Take picture")
                            .font(.headline)
                            .frame(width:100)
                            .foregroundColor(Color.black)
                    }
                    .padding(17)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .padding(10)
                }
                .alert(isPresented: $needAvatar) {
                    Alert(title: Text("You must create an avatar first"), message: Text(""), dismissButton: .default(Text("OK")))
                }
                .background(
                    NavigationLink(destination: NewPictureView(CC:CC, selectedTab: $selectedTab, clothing: clothing, selected: $selected),
                        isActive: $selected) { EmptyView() }
                )
                Spacer()
            }
        }
        .alert(isPresented: $needSelect) {
            Alert(title: Text("You must select the clothing type"), message: Text(""), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $clothing.choosingPhoto, onDismiss: {
            selected = true
        }) {
            ImagePicker(image: $clothing.image, sourceType: .camera)
        }
    }
}
