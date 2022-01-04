//
//  samplePresentVC.swift
//  AutoLayoutProject
//
//  Created by Jerold Liu on 2021/11/16.
//

import Foundation
import UIKit

enum BottomStackViewItems: Int,CaseIterable {
    case cycle = 0
    case previous = 1
    case play = 2
    case next = 3
    case recipe = 4
}

extension SamplePresentVC {
    func addItems(itemType: BottomStackViewItems) {
        switch itemType {
        case .cycle:
            let imageView = getCommonButton(imageName: "cycleplay")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            stackViewBottom.addArrangedSubview(imageView)
        case .next,.play,.previous:
            let imageView = getControlButton(index: itemType.rawValue,iconNamePrefix: "play",cornerRadius: stackHeight/2)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            stackViewBottom.addArrangedSubview(imageView)
        case .recipe:
            let imageView = getCommonButton(imageName: "recipe")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            stackViewBottom.addArrangedSubview(imageView)
        }
    }
}

class SamplePresentVC: UIViewController {
    let mainColor = UIColor(red: 34/255.0, green: 73/255.0, blue: 55/255.0, alpha: 1)
    var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let statusManager = UIApplication.shared.keyWindow?.windowScene?.statusBarManager
            return statusManager?.statusBarFrame.height ?? 20.0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }

    let stackHeight = 50.0
    lazy var iconImgView: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "album")
        return img
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var stackViewBottom: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var naviContainer: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    var iconTopConstraint:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                view.backgroundColor = .black
            } else {
                view.backgroundColor = mainColor
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let tempConstraint = iconTopConstraint else { return }
        if size.width > size.height {
            // 横屏
            stackView.spacing = 50
            tempConstraint.constant = 0
        } else {
            // 竖屏
            stackView.spacing = 30
            tempConstraint.constant = -(44+statusBarHeight)
        }
    }
    
    func setupNavigationBar() {
        view.addSubview(naviContainer)
        naviContainer.translatesAutoresizingMaskIntoConstraints = false
        naviContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        naviContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
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
    
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = mainColor
        view.addSubview(iconImgView)
        view.addSubview(stackView)
        view.addSubview(stackViewBottom)
        
        iconImgView.translatesAutoresizingMaskIntoConstraints = false
        iconTopConstraint = iconImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -statusBarHeight)
        guard let tempConstraint = iconTopConstraint else { return }
        NSLayoutConstraint.activate([tempConstraint,
                                     iconImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                                     iconImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                                     iconImgView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)])
        setupNavigationBar()
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: iconImgView.bottomAnchor, constant: 30),
                                     stackView.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)),stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
                                    )
        
        for index in 0...3 {
            let imageView = getControlButton(index: index+1,iconNamePrefix: "icon",cornerRadius: 10)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            stackView.addArrangedSubview(imageView)
        }
        
        stackViewBottom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackViewBottom.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
                                     stackViewBottom.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)),
                                     stackViewBottom.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        for bottomItem in BottomStackViewItems.allCases {
            addItems(itemType: bottomItem)
        }
        
    }
    
    func getCommonButton(imageName: String) -> UIImageView {
        let imgView = UIImageView(frame: .zero)
        imgView.image = UIImage(named: imageName)
        imgView.backgroundColor = UIColor(red: 95/255.0, green: 126/255.0, blue: 115/255.0, alpha: 1)
        return imgView
    }
    
    func getControlButton(index:Int, iconNamePrefix: String, cornerRadius: CGFloat) -> UIImageView {
        let imgView = UIImageView(frame: .zero)
        imgView.image = UIImage(named: "\(iconNamePrefix)\(index)")
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = cornerRadius
        imgView.backgroundColor = UIColor(red: 95/255.0, green: 126/255.0, blue: 115/255.0, alpha: 1)
        return imgView
    }
    
    func setUpNaviBackGroundColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [mainColor.cgColor,UIColor.green.cgColor]
        gradientLayer.locations = [0.2,1.0]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint  = CGPoint.init(x: 0, y: 1)
        gradientLayer.frame = UIScreen.main.bounds
        //最后作为背景
        naviContainer.layer.insertSublayer(gradientLayer, at: 0)
    }
}
