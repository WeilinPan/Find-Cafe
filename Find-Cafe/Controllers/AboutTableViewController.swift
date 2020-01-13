//
//  AboutTableViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/26.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    var sectionTitles = ["Author", "Cafe Nomad"]
    var sectionContents = [[(image: "facebook", title: "認識創作者", link: "https://www.facebook.com/weilin.pan.14"), (image: "github", title: "瞧瞧Find Cafe的gitHub", link: "https://github.com/WeilinPan/Find-Cafe")], [(image: "website", title: "了解Cafe Nomad", link: "https://cafenomad.tw/"), (image: "facebook", title: "晃晃Cafe Nomad的臉書", link: "https://www.facebook.com/cafenomad.tw/")] ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)
        
        // navigation bar設定
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist")}
        let appearance = UINavigationBarAppearance().self

        appearance.largeTitleTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor(red: 156 / 255, green: 60 / 255, blue: 49 / 255, alpha: 1)]
        appearance.titleTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor(red: 156 / 255, green: 60 / 255, blue: 49 / 255, alpha: 1)]
        navBar.standardAppearance = appearance
        
        // 移除額外分隔線
        tableView.tableFooterView = UIView()

    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionContents[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutTableViewCell
        let cellData = sectionContents[indexPath.section][indexPath.row]
        cell.iconImageView.image = UIImage(named: cellData.image)
        cell.titleLabel.text = cellData.title
        cell.backgroundColor = UIColor(red: 229 / 255, green: 216 / 255, blue: 191 / 255, alpha: 1)

        return cell
    }

        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = sectionContents[indexPath.section][indexPath.row].link
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: link) {
                    let sarfariController = SFSafariViewController(url: url)
                    present(sarfariController, animated: true, completion: nil)
                }
            }else if indexPath.row == 1 {
                if let url = URL(string: link) {
                    let sarfariController = SFSafariViewController(url: url)
                    present(sarfariController, animated: true, completion: nil)
                }
            }
        case 1:
            if indexPath.row == 0 {
               if let url = URL(string: link) {
                    let sarfariController = SFSafariViewController(url: url)
                    present(sarfariController, animated: true, completion: nil)
                }
            }else if indexPath.row == 1 {
                if let url = URL(string: link) {
                    let sarfariController = SFSafariViewController(url: url)
                    present(sarfariController, animated: true, completion: nil)
                }
            }
        default:
            break
        }
        // cell點擊後不會顯示反灰的被選擇狀態
        tableView.deselectRow(at: indexPath, animated: false)
    }


}
