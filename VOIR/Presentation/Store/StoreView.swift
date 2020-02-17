//
//  StoreView.swift
//  VOIR
//
//  Created by Andrew Krotov on 26/07/2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import UIKit

public class StoreView: UIView {
    private var goodsLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        return layout
    }
    
    private var colorsLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        
        return layout
    }
    private lazy var goodsCollection = UICollectionView(frame: .zero, collectionViewLayout: goodsLayout)
    private lazy var colorsCollection = UICollectionView(frame: .zero, collectionViewLayout: colorsLayout)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        DispatchQueue.main.async { [weak self] in
            self?.setupView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        goodsCollection.tag = 0
        colorsCollection.tag = 1
        
        goodsCollection.isPagingEnabled = true
        
        NSLayoutConstraint.activate([
            goodsCollection.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            goodsCollection.widthAnchor.constraint(equalTo: widthAnchor),
            goodsCollection.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            colorsCollection.heightAnchor.constraint(equalToConstant: 100),
            colorsCollection.widthAnchor.constraint(equalTo: widthAnchor),
            colorsCollection.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorsCollection.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            colorsCollection.topAnchor.constraint(equalTo: goodsCollection.bottomAnchor, constant: 40),
        ])
    }
}

public extension StoreView {
    func setDelegateAndDataSource(delegate: UICollectionViewDelegate & UICollectionViewDataSource) {
        [goodsCollection, colorsCollection].forEach {
            addSubview($0)
            $0.backgroundColor = .white
            $0.showsHorizontalScrollIndicator = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.delegate = delegate
            $0.dataSource = delegate
        }
        
        goodsCollection.register(GoodCell.self, forCellWithReuseIdentifier: GoodCell.reuseIdentifier)
        colorsCollection.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
    }
    
    func reloadData() {
        goodsCollection.reloadData()
        colorsCollection.reloadData()
    }
    
    func selectItem(at indexPath: IndexPath) {
        goodsCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        colorsCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        reloadData()
    }
}
