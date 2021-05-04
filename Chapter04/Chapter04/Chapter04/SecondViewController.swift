//
//  SecondViewController.swift
//  Chapter04
//
//  Created by Seungjin Baek on 2021/05/04.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func back2(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: false)
    }
    
    
}
