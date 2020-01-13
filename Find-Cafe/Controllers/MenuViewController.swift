//
//  MenuViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/26.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    
    @IBOutlet var menuButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 滑入動畫：先將button移到上方螢幕外
        let moveTopTransform = CGAffineTransform.init(translationX: 0, y: -400)
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)

        // 依序設定button的起始狀態
        menuButtons[0].transform = moveTopTransform
        menuButtons[1].transform = moveRightTransform
        for menuButton in menuButtons {
            menuButton.alpha = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 彈入的動畫
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
            self.menuButtons[0].alpha = 1.0
            self.menuButtons[0].transform = .identity
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.15, options: [], animations: {
            self.menuButtons[1].alpha = 1.0
            self.menuButtons[1].transform = .identity
        }, completion: nil)
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            // 回到登入頁面
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
