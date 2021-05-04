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
    
    @IBOutlet var firstScreenLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.firstScreenLabel.text = "천천히 변경"
        NSLog("\(segue.identifier) 세그웨이 실행")
    }

   
    
}

