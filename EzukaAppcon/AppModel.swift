//
//  AppModel.swift
//  EzukaAppcon
//
//  Created by 海野恵凜那 on 2017/10/24.
//  Copyright © 2017年 erina.umino. All rights reserved.
//

import Foundation
import Alamofire

class AppModel {
    var apps:[App] = []
    
    func fetch() {
        Alamofire.request(Router.readApps()).response { (response) in
            let json = try! JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! [Any]
            let apps = json.map({ (json) -> App in
                let data = try! JSONSerialization.data(withJSONObject: json)
                return try! JSONDecoder().decode(App.self, from: data)
            })
            self.apps = apps
        }
    }
}
