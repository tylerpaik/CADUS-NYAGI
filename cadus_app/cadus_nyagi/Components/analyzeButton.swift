import SwiftUI
import CoreML
import Vision



struct analyzeButton: View {
    @Binding var photo: UIImage?
    @Binding var videoURL: URL?
    @State private var showResultsView = false
    @State private var analysisResults: UIImage?
    
    var body: some View {
        VStack {
            NavigationLink(destination: ResultsView(results: $analysisResults), isActive: $showResultsView) {
                EmptyView()
            }
            
            Button(action: {
                processImage(photo) { result in
                    analysisResults = result
                    showResultsView = true
                }
            }) {
                ZStack {
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
    }
}

//func drawBoundingBoxes(originalImage: UIImage, boundingBoxes: [VNRecognizedObjectObservation]) -> UIImage {
//    UIGraphicsBeginImageContextWithOptions(originalImage.size, false, 0.0)
//    let context = UIGraphicsGetCurrentContext()
//
//    originalImage.draw(in: CGRect(x: 0, y: 0, width: originalImage.size.width, height: originalImage.size.height))
//
//    context?.setLineWidth(3.0)
//    context?.setStrokeColor(UIColor.red.cgColor)
//
//    // Set font for labels
//    let labelFont = UIFont.systemFont(ofSize: 14)
//    let labelAttributes: [NSAttributedString.Key: Any] = [
//        .font: labelFont,
//        .foregroundColor: UIColor.white,
//        .backgroundColor: UIColor.red
//    ]
//
//    for box in boundingBoxes {
//        var rect = VNImageRectForNormalizedRect(box.boundingBox, Int(originalImage.size.width), Int(originalImage.size.height))
//        rect.origin.y = originalImage.size.height - rect.origin.y - rect.size.height // Convert to UIKit coordinates
//
//        // Draw a small line at the center of the bounding box
//        let centerX = rect.midX
//        let centerY = rect.midY
//        let lineLength: CGFloat = 20.0
//
//        context?.move(to: CGPoint(x: centerX - lineLength / 2, y: centerY))
//        context?.addLine(to: CGPoint(x: centerX + lineLength / 2, y: centerY))
//        context?.strokePath()
//
////        context?.move(to: CGPoint(x: centerX, y: centerY - lineLength / 2))
////        context?.addLine(to: CGPoint(x: centerX, y: centerY + lineLength / 2))
////        context?.strokePath()
//
//        // Draw the label
//        if let topLabel = box.labels.first {
//            let labelText = "\(topLabel.identifier)"
//            let labelSize = (labelText as NSString).size(withAttributes: labelAttributes)
//
//            let labelRect = CGRect(x: rect.origin.x, y: rect.origin.y - labelSize.height, width: labelSize.width, height: labelSize.height)
//            labelText.draw(in: labelRect, withAttributes: labelAttributes)
//        }
//    }
//
//    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//
//    return resultImage ?? originalImage
//}

func colorForLabel(label: String) -> UIColor {
    switch label {
    case "Skin/Fat":
        return UIColor.red
    case "Deltoid":
        return UIColor.green
    case "Tendon":
        return UIColor.cyan
    case "Humerus":
        return UIColor.yellow
    default:
        return UIColor.red
    }
}

func drawBoundingBoxes(originalImage: UIImage, boundingBoxes: [VNRecognizedObjectObservation]) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(originalImage.size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()

    originalImage.draw(in: CGRect(x: 0, y: 0, width: originalImage.size.width, height: originalImage.size.height))

    context?.setLineWidth(3.0)
    
    // Calculate scale factor for resizing labels and lines
    let scaleFactor = min(originalImage.size.width / 192.0, originalImage.size.height / 320.0)
    
    // Set font for labels
    let labelFont = UIFont.systemFont(ofSize: 14 * scaleFactor)

    for box in boundingBoxes {
        var rect = VNImageRectForNormalizedRect(box.boundingBox, Int(originalImage.size.width), Int(originalImage.size.height))
        rect.origin.y = originalImage.size.height - rect.origin.y - rect.size.height // Convert to UIKit coordinates
        
        // Draw a small line at the center of the bounding box
        let centerX = rect.midX
        let centerY = rect.midY
        let lineLength: CGFloat = 20.0 * scaleFactor
        
        // Draw the label
        if let topLabel = box.labels.first {
            let labelText = "\(topLabel.identifier)"
            let lineColor = colorForLabel(label: labelText)
            context?.setStrokeColor(lineColor.cgColor)
            
            context?.move(to: CGPoint(x: centerX - lineLength / 2, y: centerY))
            context?.addLine(to: CGPoint(x: centerX + lineLength / 2, y: centerY))
            context?.strokePath()
            
            let labelAttributes: [NSAttributedString.Key: Any] = [
                .font: labelFont,
                .foregroundColor: UIColor.black,
                .backgroundColor: lineColor
            ]
            let labelSize = (labelText as NSString).size(withAttributes: labelAttributes)
            
            var labelX = centerX - labelSize.width / 2
            var labelY = centerY + lineLength / 2
            
            // Adjust label position if it goes off the screen
            if labelX + labelSize.width > originalImage.size.width {
                labelX = originalImage.size.width - labelSize.width
            }
            if labelX < 0 {
                labelX = 0
            }
            if labelY + labelSize.height > originalImage.size.height {
                labelY = originalImage.size.height - labelSize.height
            }
            
            let labelRect = CGRect(x: labelX, y: labelY, width: labelSize.width, height: labelSize.height)
            labelText.draw(in: labelRect, withAttributes: labelAttributes)
        }
    }

    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return resultImage ?? originalImage
}




func resizeImage(_ image: UIImage, newSize: CGSize) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: newSize)
    return renderer.image { _ in
        image.draw(in: CGRect(origin: .zero, size: newSize))
    }
}

func processImage(_ inputImage: UIImage?, completion: @escaping (UIImage?) -> Void) {
    guard let image = inputImage else {
        completion(nil)
        return
    }
    
    let modelInputSize = CGSize(width: 192, height: 320)
    let resizedImage = resizeImage(image, newSize: modelInputSize)
    
    let model = try? VNCoreMLModel(for: shoulder_nms().model)
    let request = VNCoreMLRequest(model: model!) { request, error in
        guard let results = request.results as? [VNRecognizedObjectObservation] else {
            completion(nil)
            return
        }
        
        let imageWithBoundingBoxes = drawBoundingBoxes(originalImage: image, boundingBoxes: results)
        completion(imageWithBoundingBoxes)
    }
    
    let handler = VNImageRequestHandler(cgImage: resizedImage.cgImage!, options: [:])
    try? handler.perform([request])
}





