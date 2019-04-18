//
//  ViewController.swift
//  AI Hackathon 2019
//
//  Created by Huzaifa Ahmed on 3/30/19.
//  Copyright © 2019 Huzaifa Ahmad. All rights reserved.
//

import UIKit
import CoreML
import Vision
import AVKit
import AVFoundation
import SPPermission


import Photos

class ViewController: UIViewController, UINavigationControllerDelegate{
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBOutlet weak var boxView: UIView!
    
    @IBAction func switchCameras(_ sender: UIButton) {
        do {
            try cameraController.switchCameras()
        }
            
        catch {
            print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
            
        case .some(.rear):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
            
        case .none:
            return
        }
    }
    let cameraController = CameraController()
    var model: thefinal!
    @IBOutlet fileprivate var captureButton: UIButton!
    @IBOutlet fileprivate var capturePreviewView: UIView!
    
    @IBOutlet fileprivate var toggleCameraButton: UIButton!
    var imageViewImage: UIImage?
    @IBAction func captureImage(_ sender: UIButton) {
        UIView.animate(withDuration: 0.8, animations: {
            self.captureButton.backgroundColor = .white
        })
        UIView.animate(withDuration: 0.8, animations: {
            self.captureButton.backgroundColor = .clear
        })

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        cameraController.captureImage {(image, error) in
            
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 28, height: 28), true, 2.0)
            image.draw(in: CGRect(x: 0, y: 0, width: 28, height: 28))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
            var pixelBuffer : CVPixelBuffer?
            let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
            guard (status == kCVReturnSuccess) else {
                return
            }
            
            CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
            
            let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
            
            context?.translateBy(x: 0, y: newImage.size.height)
            context?.scaleBy(x: 1.0, y: -1.0)
            
            UIGraphicsPushContext(context!)
            newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
            UIGraphicsPopContext()
            CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            
            guard let prediction = try? self.model.prediction(image: pixelBuffer!) else {
                return
            }
            let output = prediction.output1
            
            let out1 = output[0] as! Float * 100
            let out2 = output[1] as! Float * 100
            let out3 = output[2] as! Float * 100
            let out4 = output[3] as! Float * 100

            let message = "Actinic Keratosis +: " + String(out1) + "%, Actinic Keratosis - : " + String(out2) + "%, Melanoma +: " +  String(out3) + "%, Melanoma - : " + String(out4) + "%"
            
            let alert = UIAlertController(title: "Prediction and Confidence", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            print(prediction.output1)
        }

    }
    override var prefersStatusBarHidden: Bool { return true }
}
extension ViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if SPPermission.isAllowed(.camera) == false {
            SPPermission.Dialog.request(with: [.camera, .photoLibrary], on: self)
        }
    }
    override func viewDidLoad() {
        func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error {
                    print(error)
                }
                try? self.cameraController.displayPreview(on: self.capturePreviewView)
            }
            model = thefinal()
            
        }
        func styleCaptureButton() {
            captureButton.layer.borderColor = UIColor.white.cgColor
            captureButton.layer.borderWidth = 4
            captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
            boxView.layer.cornerRadius = 10
            boxView.layer.borderWidth = 1
            boxView.layer.borderColor = UIColor.white.cgColor
            boxView.layer.masksToBounds = true
        }
        
        styleCaptureButton()
        configureCameraController()
    }
    @IBAction func openLibrary(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
}
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        picker.dismiss(animated: true)
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
            return
        } //1
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 28, height: 28), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 28, height: 28))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        guard let prediction = try? model.prediction(image: pixelBuffer!) else {
            return
        }
        
        let output = prediction.output1
        
        let out1 = output[0] as! Float * 100
        let out2 = output[1] as! Float * 100
        let out3 = output[2] as! Float * 100
        let out4 = output[3] as! Float * 100
        
        let message = "Actinic Keratosis +: " + String(out1) + "%, Actinic Keratosis - : " + String(out2) + "%, Melanoma +: " +  String(out3) + "%, Melanoma - : " + String(out4) + "%"
        
        let alert = UIAlertController(title: "Prediction and Confidence", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        print("Library  print ",prediction.output1)
    }
}
