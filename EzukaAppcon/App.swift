//
//  App.swift
//  EzukaAppcon
//
//  Created by 海野恵凜那 on 2017/10/22.
//  Copyright © 2017年 erina.umino. All rights reserved.
//

import Foundation

struct App: Codable {
    let name: String
    let teamName: String
    let square: String
    let urls: [String]
    let about: String
    let feature: String
    
    init(name: String, teamName: String, square: String, urls:[String], about: String, feature:String) {
        self.name = name
        self.teamName = teamName
        self.square = square
        self.urls = urls
        self.about = about
        self.feature = feature
    }
}
