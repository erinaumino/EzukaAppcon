//
//  FirstViewController.swift
//  EzukaAppcon
//
//  Created by 海野恵凜那 on 2017/10/24.
//  Copyright © 2017年 erina.umino. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {

    let model = AppModel()
    
    @IBAction func startButton(_ sender: Any) {
        performSegue(withIdentifier: "list", sender: model)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model.fetch()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ListViewController
        vc.model = sender as? AppModel
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
