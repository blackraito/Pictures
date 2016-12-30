//
//  ViewController.swift
//  PicturesDemo
//
//  Created by Wipoo Shinsirikul on 30/12/16.
//  Copyright © 2016 ShopSpot. All rights reserved.
//

import UIKit

import Pictures

class ViewController: UIViewController
{
    fileprivate(set) var page: UInt = 0
    
    @IBAction func buttonDidSelect()
    {
        let pictures = Pictures<PicturesCollectionViewCell>()
        pictures.picturesDataProviderDelegate = self
        pictures.collectionView?.reloadData()
        present(pictures, animated: true, completion: nil)
    }
    
}

extension ViewController: PicturesDataProviderDelegate
{
    func picturesNeedsNewPictures(_ callback: @escaping (((newPictures: [URL], isLoadAll: Bool)) -> Void))
    {
        DispatchQueue
            .main
            .asyncAfter(
            deadline: .now() + .seconds(2)) {
                self.page += 1
                callback((newPictures: (1...30).map { self.imageURL(from: $0 * self.page) }, isLoadAll: self.page > 3))
        }
    }
}

extension ViewController
{
    fileprivate func imageURL(from index: UInt) -> URL
    {
        return URL(string: "https://unsplash.it/250/250?image=\(index)")! // swiftlint:disable:this force_unwrapping
    }
}