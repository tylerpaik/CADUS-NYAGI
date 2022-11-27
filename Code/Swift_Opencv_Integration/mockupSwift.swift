import UIKit
import AVKit

class ViewController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        //here is where we start up the camera
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return } //back camera
        //guard and else are unwrapping
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)

        captureSession.startRunning()

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
    }
}