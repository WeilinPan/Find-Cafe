//
//  MainViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/26.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField! {
           didSet {
               emailTextfield.tag = 1
               emailTextfield.delegate = self
           }
       }
    @IBOutlet weak var passwordTextfield: UITextField! {
           didSet {
               passwordTextfield.tag = 2
               passwordTextfield.delegate = self
           }
       }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 設定按鈕外觀
        buttonShape(button: loginButton)
        buttonShape(button: registerButton)
        
        // navigation bar設定
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist")}
        let appearance = UINavigationBarAppearance().self
        appearance.largeTitleTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor(red: 156 / 255, green: 60 / 255, blue: 49 / 255, alpha: 1)]
        appearance.titleTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor(red: 156 / 255, green: 60 / 255, blue: 49 / 255, alpha: 1)]
        navBar.standardAppearance = appearance

        
        titleLabel.text = ""
        // 設成Double主要是配合Timer時間間隔設0.2的關係，亦可設成Int然後在Timer裡轉成Double
        var index = 0.0
        let titleText = "Find Café☕️"
        for letter in titleText {
            // 藉由Timer的語法將字傳入時間有間隔，但只設0.1仍是一下就呈現，看不出差異，故藉由index的遞增，後續傳入的時間間隔會更大，更明顯
            Timer.scheduledTimer(withTimeInterval: 0.2 * index, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            index += 1
        }

    }
    
    // 點擊空白出讓鍵盤消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.alertMessage(error: e)
                } else {
                    self.performSegue(withIdentifier: "LoginToMenu", sender: self)
//                    self.emailTextfield.text = ""
//                    self.passwordTextfield.text = ""
                }
            }
        }
    }
    
    
    // 讓button產生圓角與陰影的外觀
    func buttonShape(button: UIButton) {
        button.layer.cornerRadius = 5.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 0.3
    }
    
    // email/password輸入內容不符合規定時會將錯誤以alert方式呈現
    func alertMessage(error: Error) {
        let alert = UIAlertController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)

    }

}

extension MainViewController: UITextFieldDelegate {
    // 按return鍵後跳到下一個textfiled
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}
