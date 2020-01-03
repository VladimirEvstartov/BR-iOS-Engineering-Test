//
//  LunchViewController.swift
//  BR iOS Engineering Test
//
//  Created by Vladimir on 28.12.2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class LunchViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter = LunchPresenter()
    private var topLeftCollectionItem: Int?
    private var layout: LunchCollectionViewLayout? {
        return collectionView?.collectionViewLayout as? LunchCollectionViewLayout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.delegate = self
        presenter.updateRestaurants()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = BRStrings.lunchTabBarTitle
        navigationItem.title = BRStrings.lunchTitle
        (navigationController as? BRNavigationController)?.mapDataSorce = presenter
    }
        
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        let visibleCells = collectionView.visibleCells.sorted { $0.tag < $1.tag}
        topLeftCollectionItem = visibleCells.first?.tag ?? 0
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        let firstIndexPath = IndexPath(item: topLeftCollectionItem ?? 0, section: 0)
        collectionView.scrollToItem(at: firstIndexPath, at: .top, animated: true)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: BRUIConstants.restaurantCellNib, bundle: nil), forCellWithReuseIdentifier: BRUIConstants.restaurantCellIdentifer)
        if let layout = layout {
            layout.delegate = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let model = sender as? Restaurant, let vc = segue.destination as? RestaurantDetailsViewController {
            vc.model = model
        
        }
    }
}

// MARK: LunchPresentorDelegate
extension LunchViewController: LunchPresentorDelegate {
    func dataFetchDidStarted() {
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
        loadingView.startSpinner()
    }
    
    func dataFetchDidFinished() {
        loadingView.stopSpinner()
    }
    
    func dataDidUpdated() {
        collectionView.reloadData()
        (navigationController as? BRNavigationController)?.updateMapButtonStatus()
    }
    
    func errorDidOccurred(_ error: Error) {
        showError(error.localizedDescription)
    }
}

// MARK: UICollectionViewDataSource
extension LunchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRestaurants(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BRUIConstants.restaurantCellIdentifer, for: indexPath)
        if let restorauntCell = cell as? LunchCollectionViewCell {
            restorauntCell.model = presenter.modelForCellAt(section: indexPath.section, row: indexPath.row)
            cell.tag = indexPath.row
        }
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension LunchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = presenter.modelForCellAt(section: indexPath.section, row: indexPath.row) else {return}
        performSegue(withIdentifier: BRUIConstants.restaurantDetailsSegue, sender: model)
    }
}

// MARK: LunchLayoutDelelate
extension LunchViewController: LunchLayoutDelelate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath) -> CGFloat {
        guard let layout = layout, let image = presenter.modelForCellAt(section: indexPath.section, row: indexPath.row)?.backgroundImage else {return 0.0}
        return image.raito * layout.columnWidth
    }
}
