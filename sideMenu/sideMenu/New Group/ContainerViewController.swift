//
//  ViewController.swift
//  sideMenu
//
//  Created by Jh's Macbook Pro on 2021/04/18.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC : UINavigationController?
    lazy var infoVC = InfoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVcs()
    }
    
    private func addChildVcs() {
        //menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        //Animate the menu
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (()->Void)? ) {
        switch menuState {
            case .opened:
                //close it
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    self.navVC? .view.frame.origin.x = 0
                } completion: { [weak self] done in
                    if done {
                        self?.menuState = .closed
                        DispatchQueue.main.async {
                            completion?()
                        }
                    }
                }
            case .closed:
                //open it
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    self.navVC? .view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                } completion: { [weak self] done in
                    if done {
                        self?.menuState = .opened
                        DispatchQueue.main.async {
                            completion?()
                        }
                    }
                }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
            switch menuItem {
            case .home:
                resetToHome()
            case .info:
                addInfo()
            case .appRation:
                break
            case .shareApp:
                break
            }
    }
    
    func addInfo() {
        let vc = self.infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    func resetToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
}
