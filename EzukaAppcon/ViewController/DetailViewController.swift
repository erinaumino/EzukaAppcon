//
//  DetailViewController.swift
//  EzukaAppcon
//
//  Created by 海野恵凜那 on 2017/10/22.
//  Copyright © 2017年 erina.umino. All rights reserved.
//

import UIKit
import SDWebImage
import QRCodeReader
import AVFoundation
import Alamofire

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var featureLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    @IBAction func voteButton(_ sender: Any) {
        // Retrieve the QRCode content
        // By using the delegate pattern
        readerVC.delegate = self
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .fullScreen
        present(readerVC, animated: true, completion: nil)
    }
    
    
    var app = App(name: "", teamName: "", square: "", urls: [], about: "", feature: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: app.square ?? "")
        mainImage.sd_setImage(with: url, completed: nil)
        nameLabel.text = app.name
        teamNameLabel.text = app.teamName
        let bigImageUrl = URL(string: app.urls[0] ?? "")
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
        let url =  URL(string: app.urls[indexPath.row] ?? "")
        cell.thumbnail.sd_setImage(with: url, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bigImageUrl = URL(string: app.urls[indexPath.row] ?? "")
        bigImage.sd_setImage(with: bigImageUrl, completed: nil)
        
        let all = collectionView.visibleCells as! [ThumbnailCollectionViewCell]
        _ = all.map { $0.thumbnail.backgroundColor = .none }
        
        let cell = collectionView.cellForItem(at: indexPath) as! ThumbnailCollectionViewCell
        cell.thumbnail.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
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

extension DetailViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        print(result.value)
        Alamofire.request(Router.vote(parameters: ["app_id": app.uid, "uid": result.value])).responseJSON { (response) in
            
            print(response.result.value)
            let json = response.result.value as! [String:String]
            switch json["code"] {
            case "0"?: print("success")
            default: print("error")
            }
        }
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "complete", sender: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
}
