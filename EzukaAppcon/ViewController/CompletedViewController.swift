//
//  CompletedViewController.swift
//  EzukaAppcon
//
//  Created by 海野恵凜那 on 2017/10/26.
//  Copyright © 2017年 erina.umino. All rights reserved.
//

import UIKit

class CompletedViewController: UIViewController {

    var timer:Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeView), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func changeView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
