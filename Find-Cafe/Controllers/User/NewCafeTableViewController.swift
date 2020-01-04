//
//  NewCafeTableViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/2.
//  Copyright © 2020 APAN. All rights reserved.
//

import UIKit

class NewCafeTableViewController: UITableViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.tag = 1
//            nameTextField.becomeFirstResponder()
        }
    }
    @IBOutlet weak var addressTextField: UITextField! {
           didSet {
            addressTextField.delegate = self
            addressTextField.tag = 2
           }
       }
    @IBOutlet weak var opentimeTextField: UITextField! {
        didSet {
            opentimeTextField.delegate = self
            opentimeTextField.tag = 3
        }
    }
    @IBOutlet weak var mrtTextField: UITextField! {
        didSet {
            mrtTextField.delegate = self
            mrtTextField.tag = 4
        }
    }
    @IBOutlet weak var urlTextField: UITextField! {
        didSet {
            urlTextField.delegate = self
            urlTextField.tag = 5
        }
    }
    @IBOutlet weak var tastyTextField: UITextField! {
        didSet {
            tastyTextField.delegate = self
            tastyTextField.tag = 6
        }
    }
    @IBOutlet weak var cityTextView: UITextView!
    @IBOutlet weak var noteTextView: UITextView! {
        didSet {
            noteTextView.tag = 7
            noteTextView.layer.cornerRadius = 5.0
            noteTextView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var cityPickerView: UIPickerView! {
        didSet {
            cityPickerView.delegate = self
            cityPickerView.dataSource = self
        }
    }
    var userCafeData: UserCafeDatas?
    var userCitiesBrain = UserCitiesBrain()
    var indexPathRow: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userCafeData = userCafeData {
            nameTextField.text = userCafeData.name
            cityTextView.text = userCafeData.city
            tastyTextField.text = userCafeData.tasty?.description
            addressTextField.text = userCafeData.address
            mrtTextField.text = userCafeData.mrt
            urlTextField.text = userCafeData.url
            opentimeTextField.text = userCafeData.open_time
            noteTextView.text = userCafeData.note
            photoImageView.image = UIImage(data: userCafeData.image!)
            photoImageView.contentMode = .scaleToFill
            photoLayout(imageView: photoImageView)
        }
    }
    
    // 點擊空白出讓鍵盤消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            // 使用相機
            let cameraAction = UIAlertAction(title: "相機", style: .default) { (action) in
                // 先判斷是否被允許使用相簿
                 if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                   let imagePicker = UIImagePickerController()
                                   imagePicker.allowsEditing = false
                                   imagePicker.sourceType = .camera
                                   imagePicker.delegate = self
                                   self.present(imagePicker, animated: true, completion: nil)
                }
            }

            // 使用相簿
            let photoLibraryAction = UIAlertAction(title: "相簿", style: .default) { (action) in
                // 先判斷是否被允許取用相簿
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            present(photoSourceRequestController, animated: true, completion: nil)
        }

    }
    
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 判斷必填項目是否有空白的情況
        if nameTextField.text == "" || addressTextField.text == "" {
            let alert = UIAlertController(title: "Oops!有少資料喔！", message: "客倌！店名與地址為必填項目喔！", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let name = nameTextField.text ?? ""
        let city = cityTextView.text ?? ""
        let tasty = Double(tastyTextField.text!) ?? 0.0
        let address = addressTextField.text ?? ""
        let mrt = mrtTextField.text ?? ""
        let url = urlTextField.text ?? ""
        let open_time = opentimeTextField.text ?? ""
        let note = noteTextView.text ?? ""
        let image = photoImageView.image?.pngData()
        
        
        userCafeData = UserCafeDatas(name: name, city: city, tasty: tasty, address: address, mrt: mrt, url: url, open_time: open_time, note: note, image: image)
    }
}

extension NewCafeTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userCitiesBrain.citiesEnName.count
    }
    
    // 顯示cloumn的內容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userCitiesBrain.citiesEnName[row]
    }
    
    // 選擇picker後執行的內容
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedData = userCitiesBrain.citiesEnName[row]
        cityTextView?.text = selectedData
    }
}

extension NewCafeTableViewController: UITextFieldDelegate {
    // 按return鍵後跳到下一個textfiled
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}

extension NewCafeTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleToFill
            photoImageView.clipsToBounds = true
        }
        
        // 選擇照片後設定auto layout並設定isActive屬性為true來啟動設定
        photoLayout(imageView: photoImageView)
        
        dismiss(animated: true, completion: nil)
    }
    
    func photoLayout(imageView: UIImageView) {
        let leadingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
    }
}
