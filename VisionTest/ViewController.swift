//
//  ViewController.swift
//  VisionTest
//
//  Created by blackRaven on 2022/08/25.
//

import UIKit
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageOrientation = CGImagePropertyOrientation(.up)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = UIImage(named: "group") {
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageOrientation = CGImagePropertyOrientation(image.imageOrientation)
            
            guard let cgImage = image.cgImage else { return }
        }
    }
    
    private func setupVision(image: CGImage) {
        let faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: self.handleFaceDetectionRequest)
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: image, orientation: imageOrientation, options: [:])
        
        do {
            try imageRequestHandler.perform([faceDetectionRequest])
        } catch let error as NSError {
            print(error)
            return 
        }
    }
    
    private func handleFaceDetectionRequest( request: VNRequest?, error: Error?) {
        
    }


}

