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

class APICafeDetailsViewController: UIViewController {
    
    
    var detailData: APIData?
    var randomNumber: Int?
    var number = Int.random(in: 1...18)
    
    @IBOutlet weak var headerView: APICafeDetailHeaderView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            if let _ = tableView.indexPathForSelectedRow, let data = detailData{
                let destinationVC = segue.destination as! APIMapViewController
                destinationVC.apiData = data

            }
        }
    }
    
}
