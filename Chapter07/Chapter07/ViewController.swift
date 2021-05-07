//
//  ViewController.swift
//  Chapter07
//
//  Created by Seungjin Baek on 2021/05/07.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var tf: UITextField!
    
    override func viewDidLoad() {
        self.tf.placeholder = "값 입력"
        self.tf.keyboardType = UIKeyboardType.alphabet
        self.tf.keyboardAppearance = UIKeyboardAppearance.dark
        self.tf.returnKeyType = UIReturnKeyType.join
        self.tf.enablesReturnKeyAutomatically = true
        
        self.tf.borderStyle = UITextField.BorderStyle.line
        self.tf.backgroundColor = UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)
        self.tf.contentVerticalAlignment = .center
        self.tf.contentHorizontalAlignment = .center
        self.tf.layer.borderColor = UIColor.darkGray.cgColor
        self.tf.layer.borderWidth = 2.0
        
        self.tf.becomeFirstResponder()
        self.tf.delegate = self
    }
    
    @IBAction func confirm(_ sender: Any) {
        self.tf.resignFirstResponder()
    }
    
    @IBAction func input(_ sender: Any) {
        self.tf.becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 편집 시작")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 삭제")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드의 내용이 \(tf.text!+string)으로 변경됨")
        if Int(string) == nil {
            if (textField.text?.count)! + string.count > 10 {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("리턴키를 누름")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드 편집 종료")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트필드 편집 종료")
    }
    
}

