//
//  BaseViewController.swift
//  AutoLayoutProject
//
//  Created by Jerold Liu on 2021/11/16.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    let mainColor = UIColor(red: 34/255.0, green: 73/255.0, blue: 55/255.0, alpha: 1)
    let subColor = UIColor(red: 95/255.0, green: 126/255.0, blue: 115/255.0, alpha: 1)
    var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let statusManager = UIApplication.shared.keyWindow?.windowScene?.statusBarManager
            return statusManager?.statusBarFrame.height ?? 20.0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }

    let stackHeight = 50.0
    lazy var naviContainer: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        refreshFeatureAppearance()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(naviContainer)
        naviContainer.translatesAutoresizingMaskIntoConstraints = false
        naviContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        naviContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        naviContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        naviContainer.heightAnchor.constraint(equalToConstant: 44+statusBarHeight).isActive = true
        
        let backButton = UIButton(frame: .zero)
        naviContainer.addSubview(backButton)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backToPrivious), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: naviContainer.leadingAnchor, constant: 15).isActive = true
        backButton.topAnchor.constraint(equalTo: naviContainer.topAnchor, constant: 0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    @objc func backToPrivious() {
        navigationController?.popViewController(animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            refreshFeatureAppearance()
        }
    }
    
    func refreshFeatureAppearance() {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
    }
}
