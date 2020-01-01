//
//  APICitiesBrain.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/27.
//  Copyright © 2019 APAN. All rights reserved.
//

import Foundation

protocol APICitiesBrainDelegate {
    func updateData(_ apiCitiesBrain: APICitiesBrain, finalData: [APIData])
    func didFailWithError(error:Error)
}

struct APICitiesBrain {
    var Cities = [APICities(name: "台北", en_name: "taipei", subhead: "台北市、新北市", image: "image1"), APICities(name: "嘉義", en_name: "chiayi", subhead: "嘉義縣、嘉義市", image: "image2"), APICities(name: "台中", en_name: "taichung", subhead: "台中市", image: "image3"), APICities(name: "高雄", en_name: "kaohsiung", subhead: "高雄市", image: "image4"), APICities(name: "桃園", en_name: "taoyuan", subhead: "桃園市", image: "image5"), APICities(name: "宜蘭", en_name: "yilan", subhead: "宜蘭縣", image: "image6"), APICities(name: "彰化", en_name: "changhua", subhead: "彰化縣", image: "image7"), APICities(name: "台南", en_name: "tainan", subhead: "台南市", image: "image8"), APICities(name: "花蓮", en_name: "hualien", subhead: "花蓮縣", image: "image9"), APICities(name: "新竹", en_name: "hsinchu", subhead: "新竹市、新竹縣", image: "image10"), APICities(name: "屏東", en_name: "pingtung", subhead: "屏東縣", image: "image11"), APICities(name: "苗栗", en_name: "miaoli", subhead: "苗栗縣", image: "image12"), APICities(name: "台東", en_name: "taitung", subhead: "台東縣", image: "image13"), APICities(name: "連江", en_name: "lienchiang", subhead: "連江縣", image: "image14"), APICities(name: "澎湖", en_name: "penghu", subhead: "澎湖縣", image: "image15"), APICities(name: "雲林", en_name: "yunlin", subhead: "雲林縣", image: "image16"), APICities(name: "基隆", en_name: "keelung", subhead: "基隆市", image: "image17"), APICities(name: "南投", en_name: "nantou", subhead: "南投縣", image: "image18")
    ]
    
    let apiUrl = "https://cafenomad.tw/api/v1.2/cafes/"
    var delegate: APICitiesBrainDelegate?
    
    func fetchCity(cityName: String) {
        let urlString = apiUrl + "\(cityName)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let parseData = self.parseJSON(cityData: safeData)
                    self.delegate?.updateData(self, finalData: parseData as! [APIData])
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(cityData: Data) -> [APIData?] {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([APIData].self, from: cityData)
            return decodeData
        } catch {
            self.delegate?.didFailWithError(error: error)
            return [nil]
        }
        
    }
}

