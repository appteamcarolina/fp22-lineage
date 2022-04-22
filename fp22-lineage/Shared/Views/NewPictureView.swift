//
//  NewPictureView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import SwiftUI

struct NewPictureView: View {
        
    @StateObject var vm: NewPictureViewModel = NewPictureViewModel()
    var defaultLine = Line()
    @State var selected: Bool = false
    @State var showPreview: Bool = false
    
    @ObservedObject var CC: ClosetController
    @Binding var selectedTab: Int
    @State var clothing: Clothing
    
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
            if !selected {
                VStack {
                    Spacer()
                        .frame(height:40)
                    HStack {
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
                            Label("What type of clothing?", systemImage: "tshirt")
                        }
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
                            Text("")
                        }
                    }
                    Text("When taking an image of an article of clothing we recommend wearing it and having it fill the frame as much as possible")
                        .padding()
                    Button {
                        if (clothing.type != "" && CC.dummy.photoChosen) {
                            selected = true
                            clothing = clothing.updatePhoto()
                        }
                    } label: {
                        VStack {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width:60, height:60)
                            Text("Take picture")
                        }
                        .padding()
                    }
                    Spacer()
                }
            } else {
                ZStack {
                    Image(uiImage: clothing.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(clothing.border)
                        .frame(width: 378, height: 504)
                    if clothing.photoChosen {
                        ZStack(alignment: .topTrailing) {
                            Canvas { context, size in
                                var path = Path()
                                path.addLines(vm.currentLine.points)
                                context.stroke(path, with: .color(Color.white), lineWidth: vm.currentLine.lineWidth)
                            }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({ value in
                                vm.changeDrawing(value: value)
                                })
                            .onEnded({ value in
                                vm.pauseDrawing()
                            })
                            )
                            .frame(width: 378, height: 504)
                            
                            VStack {
                                Button {
                                    clothing = vm.endDrawing(clothing: clothing)
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .background(Color.purple)
                                        .clipShape(Circle())
                                        .padding(2)
                                }
                                Button {
                                    vm.undo()
                                } label: {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .background(Color.orange)
                                        .clipShape(Circle())
                                        .padding(2)
                                }
                                Button {
                                    clothing = vm.endDrawing(clothing: clothing)
                                    self.showPreview = true
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .background(Color.green)
                                        .clipShape(Circle())
                                        .padding(2)
                                }
                                Button {
                                    clothing = vm.resetDrawing(clothing: clothing)
                                } label: {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .scaledToFill()
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                        .padding(2)
                                }
                                Button {
                                    clothing = Clothing(mult: 1, line: defaultLine)
                                    clothing = vm.resetDrawing(clothing: clothing)
                                    selected = false
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .padding(2)
                                }
                            }
                        }
                    }
                }
                .sheet(isPresented: $clothing.choosingPhoto) {
                    ImagePicker(image: $clothing.image, sourceType: .camera)
                }
                .sheet(isPresented: $showPreview, onDismiss: {
                    clothing = Clothing()
                    clothing = vm.resetDrawing(clothing: clothing)
                    selected = false
                    CC.saveCloset()
                }) {
                    PreviewView(CC: CC, clothing: clothing, selectedTab: $selectedTab, showPreview: $showPreview)
                }
            }
        }
    }
}
