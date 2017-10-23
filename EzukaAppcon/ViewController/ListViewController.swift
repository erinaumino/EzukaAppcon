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

    var apps: [App] = []
    var model: AppModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apps = model?.apps ?? []
        print(apps)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.app = sender as! App
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AppCollectionViewCell
        let url =  URL(string: apps[indexPath.row].square ?? "")
        cell.squareImage.sd_setImage(with: url, completed: nil)
        cell.nameLabel.text = apps[indexPath.row].name
        cell.teamNameLabel.text = apps[indexPath.row].teamName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: apps[indexPath.row])
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width / 2
        let height = width + 90
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

