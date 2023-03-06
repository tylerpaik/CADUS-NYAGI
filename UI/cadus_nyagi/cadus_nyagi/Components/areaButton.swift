//
//  areaButton.swift
//  cadus_nyagi
//
//  Created by Anna Easter on 2/24/23.
//

import SwiftUI

struct areaButton: View {
    var name: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                .frame(width: 300, height: 200)
                .coordinateSpace(name: "one")
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 3)
                )
            
            VStack(spacing: 20){
                Text(name).font(.system(size: 30))
            }.padding(75)
        }
    }
}

struct areaButton_Previews: PreviewProvider {
    static var previews: some View {
        areaButton(name: "test")
    }
}
