//
//  APICityCafeListTableViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/27.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit



class APICityCafeListTableViewController: UITableViewController {

    var cityEnName: String?
    var apiCitiesBrain = APICitiesBrain()
    var apiDatas = [APIData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        apiCitiesBrain.delegate = self
        if let cityName = cityEnName {
            apiCitiesBrain.fetchCity(cityName: cityName)
            
        }

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
        return apiDatas.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCafeCell", for: indexPath) as! APICityCafeListTableViewCell
        let random = Int.random(in: 1...18)
        cell.cafeNameLabel.text = apiDatas[indexPath.row].name
        cell.cafeImageView.image = UIImage(named: "image\(random)")
        cell.cafeAddressLabel.text = apiDatas[indexPath.row].address
        cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
        return cell
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCafeDetails" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as! APICafeDetailsViewController
                destinationVC.detailData = apiDatas[indexPath.row]
            }
        }
    }
    

}

//MARK: - APICitiesBrainDelegate Methods
extension APICityCafeListTableViewController: APICitiesBrainDelegate {
    
    func updateData(_ apiCitiesBrain: APICitiesBrain, finalData: [APIData]) {
               DispatchQueue.main.async {
                self.apiDatas = finalData
                self.tableView.reloadData()
         }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}


