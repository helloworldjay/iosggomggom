//
//  SecondViewController.swift
//  Chapter04
//
//  Created by Seungjin Baek on 2021/05/04.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func moveBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}

