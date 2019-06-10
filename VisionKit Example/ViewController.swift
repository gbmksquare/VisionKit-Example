//
//  ViewController.swift
//  VisionKit Example
//
//  Created by BumMo Koo on 10/06/2019.
//  Copyright © 2019 gbmksquare. All rights reserved.
//

import UIKit
import VisionKit

class ViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Action
    @IBAction private func tapped(scan button: UIButton) {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = self
        present(scanner, animated: true)
    }
}

extension ViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true) { [weak self] in
            self?.imageView.image = scan.imageOfPage(at: 0)
            
            guard let strongSelf = self else { return }
            UIAlertController.present(title: "Success!", message: "Document \(scan.title) scanned with \(scan.pageCount) pages.", on: strongSelf)
        }
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true) { [weak self] in
            self?.imageView.image = nil
            
            guard let strongSelf = self else { return }
            UIAlertController.present(title: "Cancelled", message: "User cancelled operation.", on: strongSelf)
        }
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true) { [weak self] in
            self?.imageView.image = nil
            
            guard let strongSelf = self else { return }
            UIAlertController.present(title: "Error", message: error.localizedDescription, on: strongSelf)
        }
    }
}

extension UIAlertController {
    static func present(title: String?, message: String?, on viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "OK", style: .default)
        alert.addAction(confirm)
        viewController.present(alert, animated: true)
    }
}
