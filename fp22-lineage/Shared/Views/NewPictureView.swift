//
//  NewPictureView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import SwiftUI

struct NewPictureView: View {
    
    @State var selected: Bool = false
    
    @State private var carousel = false
    
    @ObservedObject var CC: ClosetController
    @StateObject var vm: NewPictureViewModel = NewPictureViewModel()
    @State var clothing: Clothing
    var defaultLine = Line()
    
    init(CC: ClosetController) {
        defaultLine.points.append(CGPoint(x:0,y:0))
        defaultLine.points.append(CGPoint(x:420,y:0))
        defaultLine.points.append(CGPoint(x:420,y:560))
        defaultLine.points.append(CGPoint(x:0,y:560))
        self.CC = CC
        self.clothing = Clothing(mult: 1, line: defaultLine)
    }
    
    var body: some View {
        
        if !selected {
            VStack {
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
            .background(
                NavigationLink(destination: CarouselView(CC:CC), isActive: $carousel) {
                      EmptyView()
                    }
                )
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                    Button {
                        self.carousel = true
                    } label: {
                        Image(systemName: "house")
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.principal) {
                    Image(systemName: "plus")
                }
            }
            .navigationBarBackButtonHidden(true)
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
                            context.stroke(path, with: .color(Color.black), lineWidth: vm.storedLine.lineWidth)
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
                            NavigationLink(destination: PreviewView(CC: CC, clothing: clothing)) {
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
            .background(
                NavigationLink(destination: CarouselView(CC:CC), isActive: $carousel) {
                      EmptyView()
                    }
                )
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                    Button {
                        self.carousel = true
                    } label: {
                        Image(systemName: "house")
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.principal) {
                    Image(systemName: "plus")
                }
            }
            .navigationBarBackButtonHidden(true)
        }
            
            /*
            
            ZStack {
                Button {
                    clothing = clothing.updatePhoto()
                } label: {
                    if clothing.photoChosen {
                        Image(uiImage: clothing.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(clothing.border)
                    } else {
                        VStack {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width:70, height:70)
                            Text("Take picture of clothing")
                        }
                    }
                }
                .frame(width: 420, height: 560)
                if clothing.photoChosen {
                    ZStack(alignment: .topTrailing) {
                        Canvas { context, size in
                            var path = Path()
                            path.addLines(vm.storedLine.points)
                            context.stroke(path, with: .color(Color.black), lineWidth: vm.storedLine.lineWidth)
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
                            NavigationLink(destination: PreviewView(CC: CC, clothing: clothing)) {
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
            .navigationBarItems(leading: NavigationLink(destination: CarouselView(CC:CC)) { Image(systemName: "house") }, trailing: Image(systemName: "plus"))
            .navigationBarBackButtonHidden(true)
        }
        */
    }
}
/*
struct NewPictureView_Previews: PreviewProvider {
    static var previews: some View {
        NewPictureView()
    }
}
 */
