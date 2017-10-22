//
//  DetailViewController.swift
//  EzukaAppcon
//
//  Created by 海野恵凜那 on 2017/10/22.
//  Copyright © 2017年 erina.umino. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var featureLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    
    
    let app = App(name: "emosi", teamName: "popopo", square: "http://imgc.appbank.net/c/wp-content/uploads/2014/03/160713_iPhoneapp-1.jpg", urls: [ "https://www.apahotel.com/lp_app/img/img07.png" , "http://minakul.jp/wordpress/wp-content/uploads/2016/11/img3-1024x758.png" , "http://is4.mzstatic.com/image/thumb/Purple127/v4/16/8a/f6/168af63f-ef71-7b94-dda2-55cf9f3797e6/source/392x696bb.jpg" , "http://is4.mzstatic.com/image/thumb/Purple127/v4/e5/31/c8/e531c827-b2fa-19b5-ae0f-8a1eaeeb1fb9/source/392x696bb.jpg" ], about: "眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい。眠いです。私は今日徹夜をしています。ケーキバイキングに行きたい。マカロン食べて獅子力あげたい", feature: "まえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえまえ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: app.square)
        mainImage.sd_setImage(with: url, completed: nil)
        nameLabel.text = app.name
        teamNameLabel.text = app.teamName
        let bigImageUrl = URL(string: app.urls[0])
        bigImage.sd_setImage(with: bigImageUrl, completed: nil)
        aboutLabel.text = app.about
        featureLabel.text = app.feature
        
    }
    
    override func viewWillLayoutSubviews() {
        let height = featureLabel.frame.origin.y + featureLabel.frame.size.height + 30
        let size = CGSize(width: wrapperView.frame.size.width, height: height)
        let frame = CGRect(origin: wrapperView.frame.origin, size: size)
        wrapperView.frame = frame
        scrollView.contentSize = size

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y > 0 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Thumbnail", for: indexPath) as! ThumbnailCollectionViewCell
        let url =  URL(string: app.urls[indexPath.row])
        cell.thumbnail.sd_setImage(with: url, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bigImageUrl = URL(string: app.urls[indexPath.row])
        bigImage.sd_setImage(with: bigImageUrl, completed: nil)
        
        let all = collectionView.visibleCells as! [ThumbnailCollectionViewCell]
        _ = all.map { $0.thumbnail.backgroundColor = .none }
        
        let cell = collectionView.cellForItem(at: indexPath) as! ThumbnailCollectionViewCell
        cell.thumbnail.backgroundColor = .lightGray
        
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.height
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
