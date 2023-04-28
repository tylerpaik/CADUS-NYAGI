//
//  uploadPhotoButton.swift
//  cadus_nyagi
//
//  Created by Emmett Easter on 3/5/23.
//

//import SwiftUI
//
//struct uploadPhotoButton: View {
//    @State private var showImagePickerOptions: Bool = false
//    @State private var showImagePicker: Bool = false
//    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
//    @State private var photo:UIImage?
//    var name: String
////    var content: (GeometryProxy) -> Content
////    GeometryReader {geometry in
//    //            imageSize = CGSize(width: geometry.size.width, height: geometry.size.height)
//    //
//    //    }
//
//    var body: some View {
//        NavigationView {
//
//            if (self.photo != nil) {
//                VStack{
//                    Image(uiImage: self.photo ?? UIImage(named: "Placeholder")!)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 400,height: 400)
//                        .shadow(radius: 10)
//                        .contentShape(Circle())
//                        .onTapGesture {
//                            showImagePickerOptions = true
//                        }
//                        .padding(.top, 50)
//
//
//                    Button(LocalizationSecondary.addPhotoTitle, action: {
//                        showImagePickerOptions = true
//                    })
//                    .font(.system(size: 20))
//                    .frame(width: 200, height: 50, alignment: .center)
//                    .background(Color.blue)
//                    .foregroundColor(Color.white)
//                    .cornerRadius(10)
//                    .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
//
//
//                    analyzeButton()
//
//                    helpButton()
//                        .imageScale(.large)
//
//
//                }.background(Color(red: 0.8, green: 0.9, blue: 1))
//
//
//
//            }
//            else{
//                GeometryReader { geometry in
//                    VStack{
//                        LoopingVideoView(videoName: name.uppercased())
//                            .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9 * (1080 / 1920))
//                            .padding()
//
//                        ZStack{
//                            Color(red: 0.8, green: 0.9, blue: 1)
//
//                            VStack{
//                                Button(Localization.addPhotoTitle, action: {
//                                    showImagePickerOptions = true
//                                })
//                                .font(.system(size: 20))
//                                .frame(width: 200, height: 50, alignment: .center)
//                                .background(Color.blue)
//                                .foregroundColor(Color.white)
//                                .cornerRadius(10)
//                                .padding(30)
//                                .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
//
//                                helpButton()
//                                    .imageScale(.large)
//                                    .frame(alignment: .trailingLastTextBaseline)
//
//                            }.frame(width: 350, height: 200)
//                                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
//                        }
//                    }.background(Color(red: 0.8, green: 0.9, blue: 1))
//                }
//            }
//
//
//
//        }
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: self.$photo, isShown: self.$showImagePicker, sourceType: self.sourceType)
//        }
//    }
//}
//
//struct uploadPhotoButton_Previews: PreviewProvider {
//    static var previews: some View {
//        uploadPhotoButton(name: "test")
//    }
//}
//
//
//private enum Localization {
//    static let addPhotoTitle = NSLocalizedString("Add Ultrasound", comment: "Button title for Add Photo")
//}
//
//private enum LocalizationSecondary {
//    static let addPhotoTitle = NSLocalizedString("Change Ultrasound", comment: "Button title for Add Photo")
//}


// V2


//import SwiftUI
//import AVKit
//
//
//import PhotosUI
//
//struct MediaPicker: UIViewControllerRepresentable {
//    @Binding var photo: UIImage?
//    @Binding var videoURL: URL?
//    @Binding var isShown: Bool
//    var sourceType: UIImagePickerController.SourceType
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<MediaPicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = sourceType
//        picker.mediaTypes = ["public.image", "public.movie"]
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MediaPicker>) {}
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: MediaPicker
//
//        init(_ parent: MediaPicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.photo = image
//                parent.videoURL = nil
//            } else if let url = info[.mediaURL] as? URL {
//                parent.photo = nil
//                parent.videoURL = url
//            }
//            parent.isShown = false
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.isShown = false
//        }
//    }
//}
//
//struct UploadMediaButton: View {
//    @State private var showImagePickerOptions: Bool = false
//    @State private var showImagePicker: Bool = false
//    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
//    @State private var photo: UIImage?
//    @State private var videoURL: URL?
//    @State private var selectedFrame: UIImage?
//    @State private var scrubPosition: Double = 0
//    var name: String
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                if let photo = self.photo {
//                    imageSection(image: photo)
//                } else if let videoURL = self.videoURL {
//                    videoSection(videoURL: videoURL)
//                } else {
//                    initialSection()
//                }
//            }
//            .sheet(isPresented: $showImagePicker) {
//                MediaPicker(photo: self.$photo, videoURL: self.$videoURL, isShown: self.$showImagePicker, sourceType: self.sourceType)
//            }
//        }
//    }
//
//    private func imageSection(image: UIImage) -> some View {
//        VStack {
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 400, height: 400)
//                .shadow(radius: 10)
//                .contentShape(Circle())
//                .onTapGesture {
//                    showImagePickerOptions = true
//                }
//                .padding(.top, 50)
//
//            Button(LocalizationSecondary.addPhotoTitle, action: {
//                showImagePickerOptions = true
//            })
//            .font(.system(size: 20))
//            .frame(width: 200, height: 50, alignment: .center)
//            .background(Color.blue)
//            .foregroundColor(Color.white)
//            .cornerRadius(10)
//            .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
//
//            analyzeButton()
//
//            helpButton()
//                .imageScale(.large)
//        }
//        .background(Color(red: 0.8, green: 0.9, blue: 1))
//    }
//
//    private func videoSection(videoURL: URL) -> some View {
//        VStack {
//            VideoPlayer(player: AVPlayer(url: videoURL))
//                .frame(height: 400)
//                .cornerRadius(10)
//                .padding(.top, 50)
//
//            Slider(value: $scrubPosition, in: 0...1, onEditingChanged: { _ in
//                selectFrame(at: scrubPosition)
//            })
//            .padding()
//
//            Button(LocalizationSecondary.addPhotoTitle, action: {
//                showImagePickerOptions = true
//            })
//            .font(.system(size: 20))
//            .frame(width: 200, height: 50, alignment: .center)
//            .background(Color.blue)
//            .foregroundColor(Color.white)
//            .cornerRadius(10)
//            .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
//
//            analyzeButton()
//
//            helpButton()
//                .imageScale(.large)
//        }
//        .background(Color(red: 0.8, green: 0.9, blue: 1))
//    }
//
//    private func initialSection() -> some View {
//        GeometryReader { geometry in
//VStack {
//                    LoopingVideoView(videoName: name.uppercased())
//                        .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9 * (1080 / 1920))
//                        .padding()
//
//                    ZStack {
//                        Color(red: 0.8, green: 0.9, blue: 1)
//
//                        VStack {
//                            Button(Localization.addPhotoTitle, action: {
//                                showImagePickerOptions = true
//                            })
//                            .font(.system(size: 20))
//                            .frame(width: 200, height: 50, alignment: .center)
//                            .background(Color.blue)
//                            .foregroundColor(Color.white)
//                            .cornerRadius(10)
//                            .padding(30)
//                            .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
//
//                            helpButton()
//                                .imageScale(.large)
//                                .frame(alignment: .trailingLastTextBaseline)
//                        }
//                        .frame(width: 350, height: 200)
//                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
//                    }
//                }
//                .background(Color(red: 0.8, green: 0.9, blue: 1))
//            }
//        }
//
//private func selectFrame(at position: Double) {
//        guard let videoURL = self.videoURL else { return }
//        let asset = AVURLAsset(url: videoURL)
//        let duration = asset.duration
//    let time = CMTime(value: Int64(Double(duration.value) * position), timescale: duration.timescale)
//
//        let imageGenerator = AVAssetImageGenerator(asset: asset)
//        imageGenerator.appliesPreferredTrackTransform = true
//
//        var actualTime = CMTime.zero
//        if let imageRef = try? imageGenerator.copyCGImage(at: time, actualTime: &actualTime) {
//            selectedFrame = UIImage(cgImage: imageRef)
//        }
//    }
//}
//
//struct UploadMediaButton_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadMediaButton(name: "test")
//    }
//}
//
//private enum Localization {
//    static let addPhotoTitle = NSLocalizedString("Add Media", comment: "Button title for Add Photo or Video")
//}
//
//private enum LocalizationSecondary {
//    static let addPhotoTitle = NSLocalizedString("Change Media", comment: "Button title for Change Photo or Video")
//}


// V3

import SwiftUI
import AVKit
import PhotosUI

struct MediaPicker: UIViewControllerRepresentable {
    @Binding var photo: UIImage?
    @Binding var videoURL: URL?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MediaPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.mediaTypes = ["public.image", "public.movie"]
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MediaPicker>) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: MediaPicker

        init(_ parent: MediaPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.photo = image
                parent.videoURL = nil
            } else if let url = info[.mediaURL] as? URL {
                parent.photo = nil
                parent.videoURL = url
            }
            parent.isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
    }
}

struct UploadMediaButton: View {
    @State private var showImagePickerOptions: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var photo: UIImage?
    @State private var videoURL: URL?
    var name: String
    
    var body: some View {
        NavigationView {
            VStack {
                if let photo = self.photo {
                    imageSection(image: photo)
                } else if let videoURL = self.videoURL {
                    videoSection(videoURL: videoURL)
                } else {
                    initialSection()
                }
            }
            .sheet(isPresented: $showImagePicker) {
                MediaPicker(photo: self.$photo, videoURL: self.$videoURL, isShown: self.$showImagePicker, sourceType: self.sourceType)
            }
        }
    }
    
    private func imageSection(image: UIImage) -> some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
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
            
            analyzeButton(photo: $photo, videoURL: $videoURL)
            
            helpButton()
                .imageScale(.large)
        }
        .background(Color(red: 0.8, green: 0.9, blue: 1))
    }
    
    private func videoSection(videoURL: URL) -> some View {
        VStack {
            VideoPlayer(player: AVPlayer(url: videoURL))
                .frame(height: 400)
                .cornerRadius(10)
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
            
            analyzeButton(photo: $photo, videoURL: $videoURL)

            
            helpButton()
                .imageScale(.large)
        }
        .background(Color(red: 0.8, green: 0.9, blue: 1))
    }
    
    private func initialSection() -> some View {
        GeometryReader { geometry in
            VStack {
                LoopingVideoView(videoName: name.uppercased())
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9 * (1080 / 1920))
                    .padding()
                
                ZStack {
                    Color(red: 0.8, green: 0.9, blue: 1)
                    
                    VStack {
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
                    }
                    .frame(width: 350, height: 200)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                }
            }
            .background(Color(red: 0.8, green: 0.9, blue: 1))
        }
    }
}

private enum Localization {
    static let addPhotoTitle = NSLocalizedString("Add Media", comment: "Button title for Add Photo or Video")
}

private enum LocalizationSecondary {
    static let addPhotoTitle = NSLocalizedString("Change Media", comment: "Button title for Change Photo or Video")
}
