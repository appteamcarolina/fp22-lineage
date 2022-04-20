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
        self.clothing = Clothing(mult: 1, line: defaultLine)
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
                                clothing = clothing.updateType(type: "Hat")
                            } label: {
                                Text("Hat")
                            }
                            Button {
                                clothing = clothing.updateType(type: "Jacket")
                            } label: {
                                Text("Jacket")
                            }
                            Button {
                                clothing = clothing.updateType(type: "Top")
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
                        Text("\(clothing.type)")
                    }
                    Text("When taking an image of clothing, make sure that it is centered and you are in a well lit area")
                        .padding()
                    Button {
                        if clothing.type != "" {
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
                        .frame(width: 420, height: 560)
                    if clothing.photoChosen {
                        ZStack(alignment: .topTrailing) {
                            Canvas { context, size in
                                var path = Path()
                                path.addLines(vm.storedLine.points)
                                context.stroke(path, with: .color(Color.white), lineWidth: vm.storedLine.lineWidth)
                            }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({ value in
                                vm.changeDrawing(value: value)
                                })
                            .onEnded({ value in
                                clothing = vm.endDrawing(clothing: clothing)
                            })
                            )
                            .frame(width: 420, height: 560)
                            
                            VStack {
                                Button {
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
                    clothing = Clothing(mult: 1, line: defaultLine)
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
