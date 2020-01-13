//
//  UserCityCafeListTableViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/1.
//  Copyright © 2020 APAN. All rights reserved.
//

import UIKit
import Firebase


class UserCityCafeListTableViewController: UITableViewController {
    
    var cityEnName: String!
    var userCafeDatas = [UserCafeDatas]()
    let db = Firestore.firestore()
    let defaultURL = "https://firebasestorage.googleapis.com/v0/b/find-cafe-8c443.appspot.com/o/804341E1-77D3-4E25-9372-781D06A7E8A3.jpg?alt=media&token=cb023511-760f-45f7-8665-5b8dd0f4c2fc"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
        tableView.separatorStyle = .none

        
        loadCafeData()
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userCafeDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCafeCell", for: indexPath) as! UserCityCafeListTableViewCell
        cell.cafeNameLabel.text = userCafeDatas[indexPath.row].name
        cell.cafeAddressLabel.text = userCafeDatas[indexPath.row].address
        if let image = userCafeDatas[indexPath.row].image {
            cell.cafeImageView.image = UIImage(data: image)
        }
        
        cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
        return cell
    }
    
    @IBAction func unwinToNewCafeTableView(segue: UIStoryboardSegue) {
        if let source = segue.source as? NewCafeTableViewController, let userCafeData = source.userCafeData, let userId = Auth.auth().currentUser?.email  {
            let docuementId = userCafeData.date
            let ref = db.collection(userId).document("cities").collection(cityEnName)
            let data = ["name": userCafeData.name, "city": userCafeData.city, "tasty": userCafeData.tasty!, "address": userCafeData.address, "mrt": userCafeData.mrt!, "url": userCafeData.url!, "open_time": userCafeData.open_time!, "note": userCafeData.note!, "imageURL": userCafeData.imageURL ?? defaultURL, "date": docuementId, "storageName": userCafeData.storageName! ] as [String : Any]
            if source.editMode {
                ref.document(docuementId).updateData(data, completion: { (error) in
                    if let e = error {
                        print("There was an issue saving data to firestore, \(e)")
                    } else {
                        print("Successfully updated data.")
                    }
                })
            } else {
                ref.document(docuementId).setData(data) { (error) in
                    if let e = error {
                        print("There was an issue saving data to firestore, \(e)")
                    } else {
                        print("Successfully saved data.")
                    }
                }
            }
        }
    }
    
    func loadCafeData() {
        let userId = Auth.auth().currentUser?.email
        let ref = db.collection(userId!).document("cities").collection(cityEnName!)
        ref.order(by: "date", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
                self.userCafeDatas = []
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            
                            if let name = data["name"] as? String, let city = data["city"] as? String, let tasty = data["tasty"] as? Double, let address = data["address"] as? String, let mrt = data["mrt"] as? String, let url = data["url"] as? String, let open_time = data["open_time"] as? String, let note = data["note"] as? String, let imageURL = data["imageURL"] as? String, let date = data["date"] as? String, let storageName = data["storageName"] as? String {
                                if let imageUrl = URL(string: imageURL) {
                                    let task = URLSession.shared.dataTask(with: imageUrl, completionHandler: {(data, response, error) in
                                        if let e = error {
                                            print("\(e)")
                                        }else if let imageData = data {
                                            let newUserCafeDatas = UserCafeDatas(name: name, city: city, tasty: tasty, address: address, mrt: mrt, url: url, open_time: open_time, note: note, image: imageData, imageURL: imageURL, date: date, storageName: storageName)
                                            self.userCafeDatas.append(newUserCafeDatas)
                                            
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        }
                                    })
                                    task.resume()
                                }
                            }
                        }
                    }
                    
                }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserCafeDetails" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as! UserCafeDetailViewController
                destinationVC.detailData = userCafeDatas[indexPath.row]
                print(userCafeDatas)
            }
        }
    }
    
    // remove cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let userId = Auth.auth().currentUser?.email
        let ref = db.collection(userId!).document("cities").collection(cityEnName!)
        let documentId = userCafeDatas[indexPath.row].date
        let imageURL = userCafeDatas[indexPath.row].imageURL
        let storageName = userCafeDatas[indexPath.row].storageName
        
        userCafeDatas.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        ref.document(documentId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        if imageURL! == defaultURL {
            return
        }else{
            let storageRef = Storage.storage().reference().child("Find-Cafe").child(storageName!)
            storageRef.delete { (error) in
                if let e = error {
                    print("Error deleting file: \(e)")
                } else {
                    print("File successfully deleted")
                }
            }
        }
    }
    
    
    
    
}
