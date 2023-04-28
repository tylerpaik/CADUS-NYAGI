//
//  uploadPhotoButton.swift
//  cadus_nyagi
//
//  Created by Anna Easter on 3/5/23.
//

import SwiftUI

struct uploadPhotoButton: View {
    @State private var showImagePickerOptions: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var photo:UIImage?
//    var content: (GeometryProxy) -> Content
//    GeometryReader {geometry in
    //            imageSize = CGSize(width: geometry.size.width, height: geometry.size.height)
    //
    //    }

    var body: some View {
        NavigationView {
            
            if (self.photo != nil) {
                VStack{
                    Image(uiImage: self.photo ?? UIImage(named: "Placeholder")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400,height: 400)
                        .shadow(radius: 10)
                        .contentShape(Circle())
                        .onTapGesture {
                            showImagePickerOptions = true
                        }
                        .padding(.top, 50)
                    
                    
                    Button(LocalizationSecondary.addPhotoTitle, action: {
                        showImagePickerOptions = true
                    })
                    .font(.system(size: 20))
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
                    
                    
                    analyzeButton()
                    
                    helpButton()
                        .imageScale(.large)
                    
                    
                }.background(Color(red: 0.8, green: 0.9, blue: 1))
                
                
                
            }
            else{
                ZStack{
                    Color(red: 0.8, green: 0.9, blue: 1)
                    
                    VStack{
                        Button(Localization.addPhotoTitle, action: {
                            showImagePickerOptions = true
                        })
                        .font(.system(size: 20))
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding(30)
                        .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
                        
                        helpButton()
                            .imageScale(.large)
                            .frame(alignment: .trailingLastTextBaseline)
                        
                    }.frame(width: 350, height: 200)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                }
            }
                
            
            
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$photo, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

struct uploadPhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        uploadPhotoButton()
    }
}


private enum Localization {
    static let addPhotoTitle = NSLocalizedString("Add Ultrasound", comment: "Button title for Add Photo")
}

private enum LocalizationSecondary {
    static let addPhotoTitle = NSLocalizedString("Change Ultrasound", comment: "Button title for Add Photo")
}
