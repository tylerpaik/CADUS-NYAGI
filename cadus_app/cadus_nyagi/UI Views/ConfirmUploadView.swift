//
//  ConfirmUploadView.swift
//  cadus_nyagi
//
//  Created by Emmett Easter on 3/5/23.
//

import SwiftUI

struct ConfirmUploadView: View {
    @State private var showImagePickerOptions: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var photo:UIImage?
    
    var body: some View {
        
        if (self.photo != nil) {
            Image(uiImage: self.photo ?? UIImage(named: "Placeholder")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .cornerRadius(100)
                .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.secondary, lineWidth: 1))
                .shadow(radius: 10)
                .contentShape(Circle())
                .onTapGesture {
                    showImagePickerOptions = true
                }
                .padding(.top, 60)
            
        }
        ZStack {
            
            Image(uiImage: self.photo!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .cornerRadius(100)
                .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.secondary, lineWidth: 1))
                .shadow(radius: 10)
                .contentShape(Circle())
                .padding(.top, 60)
        }
    }
}

struct ConfirmUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmUploadView()
    }
}
