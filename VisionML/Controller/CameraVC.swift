//
//  ViewController.swift
//  VisionML
//
//  Created by Marcus Ng on 8/18/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController {

    // Outlets
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var roundedLblView: RoundedShadowView!
    @IBOutlet weak var captureImgView: RoundedShadowImageView!
    @IBOutlet weak var flashBtn: RoundedShadowButtonView!
    @IBOutlet weak var identificationLbl: UILabel!
    @IBOutlet weak var confidenceLbl: UILabel!
    
    // Vars
    var captureSession: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = cameraView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            // Input
            let input = try AVCaptureDeviceInput(device: backCamera!)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            // Output
            cameraOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddOutput(cameraOutput) {
                captureSession.addOutput(cameraOutput!)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                cameraView.layer.addSublayer(previewLayer!)
                captureSession.startRunning()
            }
            
        } catch {
            debugPrint(error)
        }
    }
    
    @IBAction func flashBtnPressed(_ sender: Any) {
        
    }
    
}

