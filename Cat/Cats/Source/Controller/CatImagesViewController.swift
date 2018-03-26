//
//  CatImagesViewController.swift
//  Assignment3
//
//  Created by Charles Augustine on 7/9/15.
//
//


import UIKit


class CatImagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	// MARK: UICollectionViewDataSource
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return imageNames.count
	}

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
		cell.imageView.image = UIImage(named: imageNames[indexPath.item])

		return cell
	}

	// MARK: Properties
	var imageNames = Array<String>() {
		didSet {
			if(self.isViewLoaded()) {
				imageCollectionView.reloadData()
			}
		}
	}

	// MARK: Properties (IBOutlet)
	@IBOutlet private weak var imageCollectionView: UICollectionView!
}