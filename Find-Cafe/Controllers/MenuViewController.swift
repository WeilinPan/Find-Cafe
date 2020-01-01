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
//        // 放大動畫：先將button放大
//        let scaleUpTransform = CGAffineTransform.init(scaleX: 10.0, y: 10.0)
//        // 合併動畫
//        let moveScaleTransformOne = scaleUpTransform.concatenating(moveTopTransform)
//        let moveScaleTransformTwo = scaleUpTransform.concatenating(moveRightTransform)
        // 依序設定button的起始狀態
        menuButtons[0].transform = moveTopTransform
        menuButtons[1].transform = moveRightTransform
        for menuButton in menuButtons {
            menuButton.alpha = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        // 彈入的動畫
//        for i in 0...(menuButtons.count - 1) {
//            UIView.animate(withDuration: 0.8, delay: (0.1 + 0.5 * Double(i)), usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
//                self.menuButtons[i].alpha = 1.0
//                // 回到原先定義的位置
//                self.menuButtons[i].transform = .identity
//            }, completion: nil)
//        }
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
