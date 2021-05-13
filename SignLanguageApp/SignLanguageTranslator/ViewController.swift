//
//  ViewController.swift
//  SignLanguageTranslator
//
//  Created by Juan David Torres  on 21/04/21.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController {
    @IBOutlet weak var buttonChooseImage: UIButton!
    @IBOutlet weak var buttonLiveTranslation: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonChooseImage.layer.cornerRadius = 10
        buttonChooseImage.clipsToBounds = true
        
        buttonLiveTranslation.layer.cornerRadius = 10
        buttonLiveTranslation.clipsToBounds = true
    }
    


}

