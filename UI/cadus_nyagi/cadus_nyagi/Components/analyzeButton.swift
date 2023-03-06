//
//  ultrasoundButton.swift
//  cadus_nyagi
//
//  Created by Anna Easter on 2/24/23.
//

import SwiftUI

struct analyzeButton: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                .frame(width: 200, height: 50)
                .coordinateSpace(name: "one")
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 3)
                )
            
            VStack(spacing: 5){
                Text("Analyze").font(.system(size: 20))
            }.padding(0.0)
        }
    }
}

struct analyzeButton_Previews: PreviewProvider {
    static var previews: some View {
        analyzeButton()
    }
}
