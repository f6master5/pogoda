//
//  CityDetailViewController.swift
//  pogoda
//
//  Created by user on 5/29/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CityDetailViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var cityTempLabel: UILabel!
    
    var cityName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLabel.text = cityName
         getTempFromCity(name: cityName)
        
    }
    
    
    
    func getTempFromCity(name: String) {
        let url = "http://api.weatherapi.com/v1/current.json?key=2d1d30ac41eb456bb37174240202705&q=\(cityName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(url as! URLConvertible, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.cityTempLabel.text = String(json["current"]["temp_c"].doubleValue)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
