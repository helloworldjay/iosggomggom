//
//  ViewController.swift
//  Chapter07
//
//  Created by Seungjin Baek on 2021/05/07.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        picker.delegate = self
        
        self.present(picker, animated: false)
    }
}

// MARK:- 이미지 피커 컨트롤러 델리게이트 메소드
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false) { () in
            let alert = UIAlertController(title:"", message: "이미지 선택 취소", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false) { () in
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imgView.image = img
        }
    }
}

// MARK:- 네비게이션 컨트롤러 델리게이트 메소드
extension ViewController: UINavigationControllerDelegate {
    
}

