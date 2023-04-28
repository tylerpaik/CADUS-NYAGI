//
//  homeButton.swift
//  cadus_nyagi
//
//  Created by Emmett Easter on 2/24/23.
//

import SwiftUI

struct helpButton: View {
    var body: some View {
        Image(systemName: "questionmark.app")
            .frame(width: 300, alignment: .trailing)
    }
}

struct helpButton_Previews: PreviewProvider {
    static var previews: some View {
        helpButton()
    }
}
