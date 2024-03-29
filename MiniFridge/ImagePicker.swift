////
////  UseModel.swift
////  MiniFridge
////
////  Created by 🐽 on 30/9/2020.
////  Copyright © 2020 chizi. All rights reserved.
////
//
//import UIKit
//import CoreML
//
//class ViewController: UIViewController, UINavigationControllerDelegate {
//    
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var classifier: UILabel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    @IBAction func camera(_ sender: Any) {
//        
//        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
//            return
//        }
//        
//        let cameraPicker = UIImagePickerController()
//        cameraPicker.delegate = self
//        cameraPicker.sourceType = .camera
//        cameraPicker.allowsEditing = false
//        
//        present(cameraPicker, animated: true)
//    }
//    
//    @IBAction func openLibrary(_ sender: Any) {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = false
//        picker.delegate = self
//        picker.sourceType = .photoLibrary
//        present(picker, animated: true)
//    }
//    
//    var model: MobileNetV2!
//    
//    override func viewWillAppear(_ animated: Bool) {
//        model = MobileNetV2()
//    }
//}
//
//extension ViewController: UIImagePickerControllerDelegate {
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        picker.dismiss(animated: true)
//        classifier.text = "Analyzing Image..."
//        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
//            return
//        }
//        
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: 224, height: 224), true, 2.0)
//        image.draw(in: CGRect(x: 0, y: 0, width: 304, height: 228))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        
//        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
//        var pixelBuffer : CVPixelBuffer?
//        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
//        guard (status == kCVReturnSuccess) else {
//            return
//        }
//        
//        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
//        
//        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
//        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
//        
//        context?.translateBy(x: 0, y: newImage.size.height)
//        context?.scaleBy(x: 1.0, y: -1.0)
//        
//        UIGraphicsPushContext(context!)
//        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
//        UIGraphicsPopContext()
//        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//        imageView.image = newImage
//        
//        guard let prediction = try? model.prediction(image: pixelBuffer!) else {
//            return
//        }
//
//        classifier.text = "\(prediction.classLabel)."
//    }
//}
//
//struct UseModel_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
