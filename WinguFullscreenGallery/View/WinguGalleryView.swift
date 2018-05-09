//
//  WinguGalleryView.swift
//  WinguFullscreenGallery
//
//  Created by Jakub Mazur on 04/05/2018.
//  Copyright © 2018 wingu GmbH. All rights reserved.
//

import UIKit

public class WinguGalleryView: WinguNibLoadingView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var assets: [ImageAsset?]? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.collectionView.register(UINib.init(nibName: String(describing: WinguGalleryCollectionViewCell.self), bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: WinguGalleryCollectionViewCell.reusableIdentifier)
    }
}

extension WinguGalleryView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WinguGalleryCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: WinguGalleryCollectionViewCell.reusableIdentifier, for: indexPath) as? WinguGalleryCollectionViewCell)!
        cell.withImageAsset(assets?[indexPath.row])
        return cell
    }
}

extension WinguGalleryView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? WinguGalleryCollectionViewCell)?.cancelPendingDataTask()
    }
}

extension WinguGalleryView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(collectionView.frame.size.width), height: floor(collectionView.frame.size.height))
    }
}
