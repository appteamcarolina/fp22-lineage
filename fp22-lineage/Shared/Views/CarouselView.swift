//
//  CarouselView.swift
//  fp22-lineage
//
//  Created by Jackson Dowden on 4/11/22.
//

import SwiftUI

struct CarouselView: View {
    
    @State private var newPic = false
  
    @State var dummy: Dummy
    
    @State var warning = false
    
    @State var tucked = false
    
    @ObservedObject var CC: ClosetController
    @Binding var selectedTab: Int
    
    init(CC: ClosetController, selectedTab: Binding<Int>) {
        self.CC = CC
        self._selectedTab = selectedTab
        self.dummy = CC.dummy
    }
    
    var body: some View {

        VStack {
            Text("Select an Outfit!")
                .font(.title)
                .fontWeight(.bold)
                .padding(15)
            ZStack {
                ZStack {
                    Image(uiImage: dummy.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 378, height: 504)
                    if !tucked {
                        if (CC.bottomsIndex != 0) {
                            let bottoms = CC.getClothing(type: "Bottoms", index: CC.bottomsIndex)
                            Image(uiImage: bottoms.image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(bottoms.border)
                                .frame(width: bottoms.width, height: bottoms.height)
                                .position(bottoms.location)
                        }
                    }
                    if (CC.topIndex != 0) {
                        let top = CC.getClothing(type: "Tops", index: CC.topIndex)
                        Image(uiImage: top.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(top.border)
                            .frame(width: top.width, height: top.height)
                            .position(top.location)
                    }
                    if tucked {
                        if (CC.bottomsIndex != 0) {
                            let bottoms = CC.getClothing(type: "Bottoms", index: CC.bottomsIndex)
                            Image(uiImage: bottoms.image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(bottoms.border)
                                .frame(width: bottoms.width, height: bottoms.height)
                                .position(bottoms.location)
                        }
                    }
                    if (CC.jacketIndex != 0) {
                        let jacket = CC.getClothing(type: "Jackets", index: CC.jacketIndex)
                        Image(uiImage: jacket.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(jacket.border)
                            .frame(width: jacket.width, height: jacket.height)
                            .position(jacket.location)
                    }
                    if (CC.hatIndex != 0) {
                        let hat = CC.getClothing(type: "Hats", index: CC.hatIndex)
                        Image(uiImage: hat.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(hat.border)
                            .frame(width: hat.width, height: hat.height)
                            .position(hat.location)
                    }
                    if (CC.shoesIndex != 0) {
                        let shoes = CC.getClothing(type: "Shoes", index: CC.shoesIndex)
                        Image(uiImage: shoes.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(shoes.border)
                            .frame(width: shoes.width, height: shoes.height)
                            .position(shoes.location)
                    }
                    HStack {
                        Rectangle()
                            .fill(Color(UIColor.systemBackground))
                            .frame(width:50, height:504)
                        Spacer()
                        Rectangle()
                            .fill(Color(UIColor.systemBackground))
                            .frame(width:50, height:504)
                    }
                }
                .frame(width: 378, height: 504)
                
                VStack {
                    Group {
                        Spacer()
                            .frame(height:20)
                        HStack {
                            Spacer()
                                .frame(width:20)
                            Button {
                                CC.changeHatIndex(val: -1, len: CC.Hats.count)
                            } label: {
                                VStack {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 30))
                                    //Text("Hat")
                                }
                            }
                            Spacer()
                            Button {
                                CC.changeHatIndex(val: 1, len: CC.Hats.count)
                            } label: {
                                VStack {
                                    //Text("Hat")
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 30))
                                }
                            }
                            Spacer()
                                .frame(width:20)
                        }
                        Spacer()
                            .frame(height:70)
                        HStack {
                            Spacer()
                                .frame(width:20)
                            Button {
                                CC.changeJacketIndex(val: -1, len: CC.Jackets.count)
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 30))
                                    //Text("Jacket")
                                }
                            }
                            Spacer()
                            Button {
                                CC.changeJacketIndex(val: 1, len: CC.Jackets.count)
                            } label: {
                                HStack {
                                    //Text("Jacket")
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 30))
                                }
                            }
                            Spacer()
                                .frame(width:20)
                        }
                    }
                    Spacer()
                        .frame(height:30)
                    HStack {
                        Spacer()
                            .frame(width:20)
                        Button {
                            CC.changeTopIndex(val: -1, len: CC.Tops.count)
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 30))
                                //Text("Top")
                            }
                        }
                        Spacer()
                        Button {
                            CC.changeTopIndex(val: 1, len: CC.Tops.count)
                        } label: {
                            HStack {
                                //Text("Top")
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 30))
                            }
                        }
                        Spacer()
                            .frame(width:20)
                    }
                    Spacer()
                        .frame(height:80)
                    HStack {
                        Spacer()
                            .frame(width:20)
                        Button {
                            CC.changeBottomsIndex(val: -1, len: CC.Bottoms.count)
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 30))
                                //Text("Bottoms")
                            }
                        }
                        Spacer()
                        Button {
                            CC.changeBottomsIndex(val: 1, len: CC.Bottoms.count)
                        } label: {
                            HStack {
                                //Text("Bottoms")
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 30))
                            }
                        }
                        Spacer()
                            .frame(width:20)
                    }
                    Spacer()
                        .frame(height:130)
                    HStack {
                        Spacer()
                            .frame(width:20)
                        Button {
                            CC.changeShoesIndex(val: -1, len: CC.Shoes.count)
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 30))
                                //Text("Shoes")
                            }
                        }
                        Spacer()
                        Button {
                            CC.changeShoesIndex(val: 1, len: CC.Shoes.count)
                        } label: {
                            HStack {
                                //Text("Shoes")
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 30))
                            }
                        }
                        Spacer()
                            .frame(width:20)
                    }
                    Spacer()
                }
                if !dummy.photoChosen {
                    Button {
                        dummy = dummy.updatePhoto()
                    } label: {
                        VStack {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width:30, height:30)
                                .foregroundColor(Color.black)
                            Text("Take picture for Avatar")
                                .font(.headline)
                                .frame(width:100)
                                .foregroundColor(Color.black)
                        }
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .offset(y:-30)
                    }
                }
            }.frame(height: 504)
            HStack {
                Button {
                    warning = true
                } label: {
                    Text("Reset Avatar")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .padding()
                }
                Button {
                    tucked.toggle()
                } label: {
                    HStack {
                        if tucked {
                            Image(systemName: "checkmark.square")
                        } else {
                            Image(systemName: "square")
                        }
                        Text("Tucked?")
                        
                    }
                }
                .alert(isPresented: $warning) {
                    Alert(
                        title: Text("Are you sure you want to reset your avatar?"),
                        message: Text("Your saved clothes will likely no longer fit correctly"),
                        primaryButton: .destructive(Text("Reset")) {
                            CC.resetDummy()
                            dummy = CC.dummy
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }.sheet(isPresented: $dummy.choosingPhoto, onDismiss: {
            CC.setDummy(dummy: dummy)
        }) {
            ImagePicker(image: $dummy.image, sourceType: .camera)
        }
    }
}
