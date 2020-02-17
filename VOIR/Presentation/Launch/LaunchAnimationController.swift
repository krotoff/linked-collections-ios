//
//  LaunchAnimationController.swift
//  VOIR
//
//  Created by Andrew Krotov on 26/07/2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import UIKit

public class LaunchAnimationController: UIViewController {
    private let image = UIImageView(image: UIImage(named: "Logo"))
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            view.widthAnchor.constraint(equalTo: image.widthAnchor, multiplier: 3.0),
            image.widthAnchor.constraint(equalTo: image.heightAnchor)
        ])
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        image.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi * 2))
        let spring = CASpringAnimation(keyPath: "transform.rotation")
        spring.damping = 12.0
        spring.fromValue = 0
        spring.toValue = CGFloat.pi * 2
        spring.duration = 1.0
        spring.autoreverses = true
        spring.delegate = self
        
        image.layer.add(spring, forKey: "rotation")
    }
}

extension LaunchAnimationController: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            appDelegate.startMainWorkflow()
        })
    }
}
