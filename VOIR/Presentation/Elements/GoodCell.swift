//
//  GoodCell.swift
//  VOIR
//
//  Created by Andrew Krotov on 26/07/2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import UIKit

public class GoodCell: UICollectionViewCell {
    static let reuseIdentifier = "goodCell"
    
    private let image = UIImageView()
    
    private let companyLabel = UILabel()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        [image, companyLabel, nameLabel, priceLabel].forEach { 
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        image.contentMode = .scaleAspectFit
        [companyLabel, nameLabel, priceLabel].forEach {
            $0.textAlignment = .center
            $0.textColor = .lightGray
            $0.setContentCompressionResistancePriority(.init(1000), for: .vertical)
        }
        nameLabel.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            companyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            companyLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            companyLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            nameLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            priceLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
        ])
    }
}

public extension GoodCell {
    func setWith(_ good: Good) {
        image.image = UIImage(
            named: good.image
                .replacingOccurrences(of: "images/", with: "")
                .replacingOccurrences(of: ".jpg", with: "")
        )
        companyLabel.text = good.vendor
        nameLabel.text = good.name
        priceLabel.text = good.price + (good.currencyID.currencySymbol ?? "")
    }
}

