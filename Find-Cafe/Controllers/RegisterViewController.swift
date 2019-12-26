//
//  RegisterViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/26.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField! {
              didSet {
                  emailTextfield.tag = 1
                  emailTextfield.becomeFirstResponder()
                  emailTextfield.delegate = self
              }
          }
    @IBOutlet weak var passwordTextfield: UITextField! {
              didSet {
                  passwordTextfield.tag = 2
                  passwordTextfield.delegate = self
              }
          }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // 點擊空白出讓鍵盤消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.alertMessage(error: e)
                } else {
                    self.performSegue(withIdentifier: "RegisterToMenu", sender: self)
                }
            }
        }
    }
    
    // email/password輸入內容不符合規定時會將錯誤以alert方式呈現
    func alertMessage(error: Error) {
        let alert = UIAlertController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }

}

extension RegisterViewController: UITextFieldDelegate {
    // 按return鍵後跳到下一個textfiled
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}
