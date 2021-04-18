//
//  HomeViewController.swift
//  sideMenu
//
//  Created by Jh's Macbook Pro on 2021/04/18.
//

import UIKit

protocol HomeViewControllerDelegate:AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
    }

    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}
