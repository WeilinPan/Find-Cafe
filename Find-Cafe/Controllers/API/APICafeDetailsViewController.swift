//
//  APICafeDetailsViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/30.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit
import MapKit
import SafariServices
import Firebase

class APICafeDetailsViewController: UIViewController {
    
    
    var detailData: APIData?
    var randomNumber: Int?
    var number = Int.random(in: 1...18)
    let db = Firestore.firestore()
    let defaultURL = "https://firebasestorage.googleapis.com/v0/b/find-cafe-8c443.appspot.com/o/804341E1-77D3-4E25-9372-781D06A7E8A3.jpg?alt=media&token=cb023511-760f-45f7-8665-5b8dd0f4c2fc"
    var userCafeData: UserCafeDatas?
    
    @IBOutlet weak var headerView: APICafeDetailHeaderView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
        if let data = detailData {
            headerView.nameLabel.text = data.name
            headerView.headerImageView.image = UIImage(named: "image\(number)")
        }
        
    }
    
    
}

extension APICafeDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: APICafeDetailTableViewCell.self), for: indexPath) as! APICafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "alarm")
            cell.infoLabel.text = detailData?.open_time ?? ""
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: APICafeDetailTableViewCell.self), for: indexPath) as! APICafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "map")
            cell.infoLabel.text = detailData?.address
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: APICafeDetailTableViewCell.self), for: indexPath) as! APICafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "tram.fill")
            cell.infoLabel.text = detailData?.mrt ?? ""
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: APICafeDetailTableViewCell.self), for: indexPath) as! APICafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "heart.circle.fill")
            cell.infoLabel.text = detailData?.tasty.description
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: APICafeDetailTableViewCell.self), for: indexPath) as! APICafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "globe")
            cell.infoLabel.text = detailData?.url ?? ""
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: APICafeDetailMapTableViewCell.self), for: indexPath) as! APICafeDetailMapTableViewCell
            if let data = detailData {
                let lat = Double(data.latitude)
                let lon = Double(data.longitude)
                let name = data.name
                cell.getLocation(lat: lat!, lon: lon!, name: name)
                
            }
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            if let urlString = detailData?.url {
                if let url = URL(string: urlString) {
                    let sarfariController = SFSafariViewController(url: url)
                    present(sarfariController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func unwinToCafeListTableView(segue: UIStoryboardSegue) {
        if let source = segue.source as? AddNewCafeTableViewController, let userCafeData = source.userCafeData, let userId = Auth.auth().currentUser?.email  {
            let docuementId = userCafeData.date
            let ref = db.collection(userId).document("cities").collection(userCafeData.city)
            let data = ["name": userCafeData.name, "city": userCafeData.city, "tasty": userCafeData.tasty!, "address": userCafeData.address, "mrt": userCafeData.mrt!, "url": userCafeData.url!, "open_time": userCafeData.open_time!, "note": userCafeData.note!, "imageURL": userCafeData.imageURL ?? defaultURL, "date": docuementId, "storageName": userCafeData.storageName! ] as [String : Any]
            ref.document(docuementId).setData(data) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            if let _ = tableView.indexPathForSelectedRow, let data = detailData{
                let destinationVC = segue.destination as! APIMapViewController
                destinationVC.apiData = data
            }
        }
        
        if segue.identifier == "addToUserList" {
            if let data = detailData {
                let destinationVC = segue.destination as! AddNewCafeTableViewController
                destinationVC.apiData = data
            }
        }
    }
    
}
