//
//  CameraViewController.swift
//  SignLanguageTranslator
//
//  Created by Juan David Torres  on 21/04/21.
//
import CoreML
import UIKit
import Vision

class CamViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {


    // MARK: IBOutlets...................
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var photoLibraryButton: UIButton!
    @IBOutlet var resultsView: UIView!
    @IBOutlet var resultsLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        resultsLabel.text = "Take a photo or choose from library"
    }

    // MARK: IBActions...................
    @IBAction func takeImageWithCamera(_ sender: Any) {
        presentPicker(with: .camera)
    }

    @IBAction func pickImageFromLibrary(_ sender: Any) {
        presentPicker(with: .photoLibrary)
    }

    lazy var vnRequest: VNCoreMLRequest = {
        let vnModel = try! VNCoreMLModel(for: asl_conv_total().model)
        let request = VNCoreMLRequest(model: vnModel) { [unowned self] request , _ in
            self.processingResult(for: request)
        }
        request.imageCropAndScaleOption = .centerCrop
        return request
    }()

    func presentPicker(with sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
        hideResultsView()
    }

    func hideResultsView() {
        self.resultsView.alpha = 0
    }

    func showResultsView() {
        self.resultsView.alpha = 1
    }

    // MARK: Function to classify image using the ML Model
    func classify(image: UIImage) {
        DispatchQueue.global(qos: .userInitiated).async {
            let ciImage = CIImage(image: image)!
            let imageOrientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: imageOrientation)
            try! handler.perform([self.vnRequest])
        }
    }

    func processingResult(for request: VNRequest) {
        DispatchQueue.main.async {
            let results = (request.results! as! [VNClassificationObservation])
            guard let observation = results.first else { return }
            let predclass = "\(observation.identifier)"
            let predconfidence = String(format: "%.02f%", observation.confidence * 100)
            
            self.resultsLabel.text = "\(predclass) \(predconfidence)"
            self.showResultsView()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        let image = info[.originalImage] as! UIImage
        imageView.image = image

        classify(image: image)
    }

}


