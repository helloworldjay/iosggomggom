//
//  ViewController.swift
//  Chapter04
//
//  Created by Seungjin Baek on 2021/05/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    

    @IBAction func moveNext(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {return}
        
        uvc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        self.present(uvc, animated: true)
    }
    
    
}

