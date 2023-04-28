//
//  PickBodyPartView.swift
//  cadus_nyagi
//
//  Created by Kaden Hawley on 4/3/23.
//

import SwiftUI

struct PickBodyPartView: View {
    @EnvironmentObject var bodyOptionsList: bodyOptions
    var name: String
    var body: some View {
//        NavigationView{
            VStack {
//                if name == "shoulder" {
                    ScrollView(.vertical, showsIndicators: false) {
                        let layout = [
                            GridItem(.adaptive(minimum: 210, maximum: 250)),
                        ]
                        
                        LazyVGrid(columns: layout) {
                            ForEach(bodyOptionsList.subSectionsDict[name] ?? [], id: \.self) { imageName in
                                NavigationLink {
                                    GiveUltrasoundView(name: imageName)
                                } label: {
                                    areaButton(name: imageName)
                                }
                            }.padding(10)                    }.padding(.top, 20)
                    }.background(Color(red: 0.8, green: 0.9, blue: 1))
//                } else {
//                    Text("No images available.")
//                }
            }
            .navigationBarTitle(name, displayMode: .inline)
//        }
    }
}

struct PickBodyPartView_Previews: PreviewProvider {
    static var previews: some View {
        PickBodyPartView(name: "shoulder")
    }
}
