//
//  ViewController.swift
//  300Sec
//
//  Created by arthur on 8/23/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let VC = SplashViewController()
        let navVC = UINavigationController(rootViewController: VC)
        setup(navVC)
        // Do any additional setup after loading the view.
        
    }
    
    func setup(_ child: UIViewController) {
        
        addChild(child)
        
        self.view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            child.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: 0 ),
            child.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            child.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
            
        ])
        child.didMove(toParent: self)
    }


}

