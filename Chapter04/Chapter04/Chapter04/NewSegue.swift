//
//  SecondViewController.swift
//  Chapter04
//
//  Created by Seungjin Baek on 2021/05/04.
//

import UIKit

class NewSegue: UIStoryboardSegue {
    
    override func perform() {
        let srcUVC = self.source
        let destUVC = self.destination
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 5, options: .transitionCurlDown)
    }
}
