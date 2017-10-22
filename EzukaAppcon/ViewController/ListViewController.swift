//
//  ListViewController.swift
//  EzukaAppcon
//
//  Created by 海野恵凜那 on 2017/10/22.
//  Copyright © 2017年 erina.umino. All rights reserved.
//

import UIKit
import SDWebImage

class ListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let app = App(name: "emosi", teamName: "popopo", square: "http://imgc.appbank.net/c/wp-content/uploads/2014/03/160713_iPhoneapp-1.jpg", urls: [ "https://www.apahotel.com/lp_app/img/img07.png" , "http://minakul.jp/wordpress/wp-content/uploads/2016/11/img3-1024x758.png" , "http://is4.mzstatic.com/image/thumb/Purple127/v4/16/8a/f6/168af63f-ef71-7b94-dda2-55cf9f3797e6/source/392x696bb.jpg" , "http://is4.mzstatic.com/image/thumb/Purple127/v4/e5/31/c8/e531c827-b2fa-19b5-ae0f-8a1eaeeb1fb9/source/392x696bb.jpg" ], about: "眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。", feature: "まえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえ")
    var apps: [App] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apps = [app, app, app, app, app, app]
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AppCollectionViewCell
        let url =  URL(string: apps[indexPath.row].square)
        cell.squareImage.sd_setImage(with: url, completed: nil)
        cell.nameLabel.text = apps[indexPath.row].name
        cell.teamNameLabel.text = apps[indexPath.row].teamName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width / 2
        let height = width + 86
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ListViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.panGestureRecognizer.translation(in: collectionView).y > 0 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
}

