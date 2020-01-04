//
//  UserCityCafeListTableViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/1.
//  Copyright © 2020 APAN. All rights reserved.
//

import UIKit

class UserCityCafeListTableViewController: UITableViewController {

    var cityEnName: String?
    var userCities = [UserCafeDatas]()
    var indexPathRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCafeCell", for: indexPath) as! UserCityCafeListTableViewCell
        cell.cafeNameLabel.text = userCities[indexPath.row].name
        cell.cafeAddressLabel.text = userCities[indexPath.row].address
        if let image = userCities[indexPath.row].image {
            cell.cafeImageView.image = UIImage(data: image)
        }
        
        cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
        return cell
    }

    @IBAction func unwinToNewCafeTableView(segue: UIStoryboardSegue) {
        if let source = segue.source as? NewCafeTableViewController, let userCafeData = source.userCafeData {
            if let index = source.indexPathRow {
                let indexPath = IndexPath(row: index, section: 0)
                userCities[index] = userCafeData
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }else{
                userCities.insert(userCafeData, at: 0)
                let newIndexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserCafeDetails" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as! UserCafeDetailViewController
                destinationVC.detailData = userCities[indexPath.row]
                destinationVC.indexPathRow = indexPath.row
            }
        }
    }
    
    // remove cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        userCities.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    

}
