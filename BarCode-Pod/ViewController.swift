//
//  ViewController.swift
//  BarCode-Pod
//
//  Created by Rohit Singh on 11/21/17.
//  Copyright © 2017 Rohit Singh. All rights reserved.
//

import UIKit
import BarcodeScanner

class ViewController: UIViewController {
    
    var scannedCode = ""

    @IBOutlet weak var btnScan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configuring UI Elememnts
        self.configureUIElements()
        
        self.title = "MAF - Barcode Scanner"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapScan(_ sender: UIButton) {
        
        let controller = BarcodeScannerController()
        controller.codeDelegate = self
        controller.errorDelegate = self
        controller.isOneTimeSearch = true
        controller.dismissalDelegate = self
        
        
        
        navigationController?.pushViewController(controller, animated: true)

    }
    
    func configureUIElements() {
        self.btnScan.layer.cornerRadius = 3.0
        self.btnScan.clipsToBounds = true
        
        
    }
    
}

extension ViewController: BarcodeScannerCodeDelegate {
    
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print(code)
        self.scannedCode = code
        BarcodeScanner.Info.loadingText = NSLocalizedString("\(scannedCode) will be sent to API.", comment: "")

        controller.reset()
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Barcode Scanner", message: "Output is : \(code)", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (actionAlert) in
                
            }
            
            alertController.addAction(action)
            
            self.present(alertController, animated: true) {
                
            }
        }
    }
}

extension ViewController: BarcodeScannerErrorDelegate {
    
    func barcodeScanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        print(error)
    }
}

extension ViewController: BarcodeScannerDismissalDelegate {

    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

