//
//  ColorCell.swift
//  VOIR
//
//  Created by Andrew Krotov on 26/07/2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import UIKit

public class ColorCell: UICollectionViewCell {
    static let reuseIdentifier = "ColorCell"
    
    private let mainCircle = UIView()
    private let backgroundCircle = UIView()
    private let whiteCircle = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        whiteCircle.backgroundColor = .white
        
        [backgroundCircle, whiteCircle, mainCircle].forEach {
            addSubview($0)
            $0.layer.masksToBounds = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            backgroundCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundCircle.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundCircle.widthAnchor.constraint(equalTo: widthAnchor),
            
            whiteCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            whiteCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            whiteCircle.heightAnchor.constraint(equalTo: heightAnchor, constant: -4),
            whiteCircle.widthAnchor.constraint(equalTo: widthAnchor, constant: -4),
            
            mainCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainCircle.heightAnchor.constraint(equalTo: heightAnchor, constant: -8),
            mainCircle.widthAnchor.constraint(equalTo: widthAnchor, constant: -8),
            ])
    }
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        [backgroundCircle, whiteCircle, mainCircle].forEach {
            $0.layer.cornerRadius = $0.frame.height / 2
        }
    }
}

public extension ColorCell {
    func setWith(_ colorString: String?, isSelected: Bool) {
        if
            let string = colorString,
            let hex = Int(string, radix: 16)
        {
            mainCircle.backgroundColor = .init(hex: hex)
            backgroundCircle.backgroundColor = .init(hex: hex)
        } else {
            mainCircle.backgroundColor = .lightGray
            backgroundCircle.backgroundColor = .lightGray
        }
        
        whiteCircle.isHidden = !isSelected
        backgroundCircle.isHidden = !isSelected
        
        layoutIfNeeded()
    }
}

