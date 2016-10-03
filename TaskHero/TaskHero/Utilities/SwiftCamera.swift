//
//  SwiftCamera.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/30/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreImage

class ViewController: UIViewController {
//    let stillImageOutput = AVCaptureStillImageOutput()
//    var imageToSave = UIImage()
//    
//    lazy var cameraSession: AVCaptureSession = {
//        let session = AVCaptureSession()
//        session.sessionPreset = AVCaptureSessionPresetHigh
//        session.usesApplicationAudioSession = false
//        return session
//    }()
//    
//    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
//        self.previewLayer =  AVCaptureVideoPreviewLayer(session: self.cameraSession)
//        self.previewLayer.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
//        self.previewLayer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
//        // stretches to fit screen
//        self.previewLayer.videoGravity = AVLayerVideoGravityResize
//        
//        let stickerLayer = CALayer(layer: self.sticker)
//        
//        self.previewLayer.addSublayer(stickerLayer)
//        self.previewLayer.insertSublayer(stickerLayer, above: self.previewLayer)
//        
//        return self.previewLayer
//    }()
//    
//    override func viewWillLayoutSubviews() {
//        let orientation: UIDeviceOrientation = UIDevice.current.orientation
//        print(orientation)
//        
//        switch orientation {
//        case .portrait:
//            self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait
//            self.previewLayer.frame = self.view.bounds
//            
//            break
//        case .landscapeLeft:
//            self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.landscapeRight
//            self.previewLayer.frame = self.view.bounds
//            break
//        case .landscapeRight:
//            self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
//            self.previewLayer.frame = self.view.bounds
//            break
//        case .portraitUpsideDown:
//            self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
//            self.previewLayer.frame = self.view.bounds
//            break
//        default:
//            self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait
//            self.previewLayer.frame = self.view.bounds
//            break
//        }
//    }
//    
//    
//   var sticker: UIImageView!
//   var picture: UIImageView!
//   var save: UIButton!
//   var selectSticker: UIButton!
//   var takePicture: UIButton!
//   var cancel: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        self.view.bringSubview(toFront: self.picture)
//        
//        setupCameraSession()
//        view.layer.addSublayer(previewLayer)
//        cameraSession.startRunning()
//        
//        self.view.bringSubview(toFront: self.save)
//        
//        self.view.bringSubview(toFront: self.selectSticker)
//        self.view.bringSubview(toFront: self.takePicture)
//        self.view.bringSubview(toFront: self.sticker)
//        
//        self.save.isHidden = true
//        self.save.isEnabled = false
//        
//        self.cancel.isHidden = true
//        self.cancel.isEnabled = false
//        
//        self.takePicture.isHidden = false
//        self.takePicture.isEnabled = true
//        
//        self.selectSticker.isHidden = false
//        self.selectSticker.isEnabled = true
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func setupCameraSession() {
//        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) as AVCaptureDevice
//        
//        do {
//            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
//            
//            cameraSession.beginConfiguration()
//            
//            if (cameraSession.canAddInput(deviceInput) == true) {
//                cameraSession.addInput(deviceInput)
//            }
//            
//            let dataOutput = AVCaptureVideoDataOutput()
//            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
//            dataOutput.alwaysDiscardsLateVideoFrames = true
//            
//            if (cameraSession.canAddOutput(dataOutput) == true) {
//                cameraSession.addOutput(dataOutput)
//            }
//            cameraSession.commitConfiguration()
//            
//        }
//        catch let error as NSError {
//            print("\(error), \(error.localizedDescription)")
//        }
//        //Makes camera session's output a StillImage
//        if cameraSession.canAddOutput(stillImageOutput) {
//            cameraSession.addOutput(stillImageOutput)
//            
//        }
//        
//    }
//    
//    func openPreview(sender: AnyObject) {
//        self.save.isHidden = false
//        self.save.isEnabled = true
//        self.view.bringSubview(toFront: save)
//        
//        self.selectSticker.isHidden = true
//        self.selectSticker.isEnabled = false
//        
//        self.cancel.isHidden = false
//        self.cancel.isEnabled = true
//        self.view.bringSubview(toFront: self.cancel)
//        
//        self.takePicture.isHidden = true
//        
//        
//        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo) {
//            stillImageOutput.captureStillImageAsynchronously(from: videoConnection) {
//                (imageDataSampleBuffer, error) -> Void in
//               // let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: imageDataSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
//                //let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
//                self.imageToSave = (UIImage(data: imageData!))!
//            }
//            
//        }
//        self.picture.image = self.imageToSave
//        
//        self.view.bringSubview(toFront: self.sticker)
//        cameraSession.stopRunning()
//    }
//    
//    //     Saves the camera's output
//    func savePicture(sender: AnyObject) {
//        self.picture.image = self.imageToSave
//        //        self.view.bringSubviewToFront(sticker)
//        let layer = UIApplication.shared.keyWindow!.layer
//        self.save.isHidden = true
//        self.selectSticker.isHidden = true
//        let scale = UIScreen.main.scale
//        
//        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
//        
//        layer.render(in: UIGraphicsGetCurrentContext()!)
//        
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        
//        UIGraphicsEndImageContext()
//        //Save it to the camera roll
//        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
//        self.save.isHidden = false
//        self.selectSticker.isHidden = false
//        viewDidLoad()
//        
//    }
//    
//    func cancelPhoto(sender: AnyObject) {
//        viewDidLoad()
//    }
}
