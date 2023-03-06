//
//  GiveUltrasoundView.swift
//  cadus_nyagi
//
//  Created by Anna Easter on 2/24/23.
//

import SwiftUI

struct GiveUltrasoundView: View {
    @State private var showImagePickerOptions: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var photo:UIImage?
    var name: String
    var body: some View {
        
        
        NavigationView{
            ZStack(){
                Color(red: 0.8, green: 0.9, blue: 1)
                
                VStack(){
                    uploadPhotoButton()
                    Spacer()
                }
            }
        }.navigationTitle(name)
        
    }
}

struct GiveUltrasoundView_Previews: PreviewProvider {
    static var previews: some View {
        GiveUltrasoundView(name: "test")
    }
}
