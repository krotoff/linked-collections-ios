//
//  StoreController.swift
//  VOIR
//
//  Created by Andrew Krotov on 26/07/2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import UIKit

public class StoreController: UIViewController {
    private let rootView = StoreView()
    
    private var products = [Good]()
    private var selectedIndex = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getData()
    }
    
    private func getData() {
        guard let filePath = Bundle.main.path(forResource: "products", ofType: "json") else {
            print("#ERR: no data in JSON")
            
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let response = try JSONDecoder().decode(Response.self, from: data)
            products = response.products
        } catch {
            print(error)
        }
        
        rootView.reloadData()
    }
    
    private func setupView() {
        rootView.setDelegateAndDataSource(delegate: self)
        
        view = rootView
    }
}

extension StoreController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodCell.reuseIdentifier, for: indexPath) as? GoodCell else {
                return .init()
            }
            
            cell.setWith(products[indexPath.row])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as? ColorCell else {
                return .init()
            }
            
            cell.setWith(products[indexPath.row].color, isSelected: indexPath.row == selectedIndex)
            
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.tag == 0
            ? collectionView.frame.size
            : .init(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView.tag == 1 else { return }
        
        selectedIndex = indexPath.row
        rootView.selectItem(at: indexPath)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard
            let collection = scrollView as? UICollectionView,
            collection.tag == 0,
            let visibleCell = collection.visibleCells.first,
            let index = collection.indexPath(for: visibleCell)
        else { return }
        
        selectedIndex = index.row
        rootView.selectItem(at: index)
    }
}
