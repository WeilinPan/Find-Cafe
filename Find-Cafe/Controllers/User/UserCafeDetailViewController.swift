//
//  UserCafeDetailViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/2.
//  Copyright © 2020 APAN. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class UserCafeDetailViewController: UIViewController {
    
    var detailData: UserCafeDatas?

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UserCafeDetailHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)

        
        if let data = detailData, let image = data.image {
            headerView.headerImageView.image = UIImage(data: image)
            headerView.nameLabel.text = data.name
        }
        
        // Do any additional setup after loading the view.
    }
    
}

extension UserCafeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCafeDetailTableViewCell.self), for: indexPath) as! UserCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "alarm")
            cell.infoLabel.text = detailData?.open_time ?? ""
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCafeDetailTableViewCell.self), for: indexPath) as! UserCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "map")
            cell.infoLabel.text = detailData?.address ?? ""
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCafeDetailTableViewCell.self), for: indexPath) as! UserCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "tram.fill")
            cell.infoLabel.text = detailData?.mrt ?? ""
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCafeDetailTableViewCell.self), for: indexPath) as! UserCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "heart.circle.fill")
            cell.infoLabel.text = detailData?.tasty?.description ?? ""
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCafeDetailTableViewCell.self), for: indexPath) as! UserCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "globe")
            cell.infoLabel.text = detailData?.url ?? ""
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCafeDetailTableViewCell.self), for: indexPath) as! UserCafeDetailTableViewCell
            cell.iconImageView.image = UIImage(systemName: "info.circle.fill")
            cell.infoLabel.text = detailData?.note ?? ""
            cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCafeDetailMapTableViewCell.self), for: indexPath) as! UserCafeDetailMapTableViewCell
            if let data = detailData {
                cell.configure(location: data.address, name: data.name)
            }
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
        if segue.identifier == "showUserMap" {
            if let _ = tableView.indexPathForSelectedRow, let data = detailData{
                let destinationVC = segue.destination as! UserMapViewController
                destinationVC.cafeData = data
            }
        }
        
        if segue.identifier == "editCafeDetail" {
            if let data = detailData {
                let destinationVC = segue.destination as! NewCafeTableViewController
                destinationVC.userCafeData = data
            }
        }
    }
}



