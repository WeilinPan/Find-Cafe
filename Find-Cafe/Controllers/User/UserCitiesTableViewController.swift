//
//  UserCitiesTableViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/1.
//  Copyright © 2020 APAN. All rights reserved.
//

import UIKit

class UserCitiesTableViewController: UITableViewController {
    
    var userCities = UserCitiesBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userCities.Cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCitiesCell", for: indexPath) as! UserCitiesTableViewCell
        cell.cityImageView.image = UIImage(named: userCities.Cities[indexPath.row].image)
        cell.cityHeadline.text = userCities.Cities[indexPath.row].name
        cell.citySubhead.text = userCities.Cities[indexPath.row].subhead
        cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToUserCityCafes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! UserCityCafeListTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.cityEnName = userCities.Cities[indexPath.row].en_name
        }
        

    }

}
