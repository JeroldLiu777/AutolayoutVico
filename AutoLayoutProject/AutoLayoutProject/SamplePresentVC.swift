//
//  samplePresentVC.swift
//  AutoLayoutProject
//
//  Created by Jerold Liu on 2021/11/16.
//

import Foundation
import UIKit

class SamplePresentVC: UIViewController {
    let mainColor = UIColor(red: 34/255.0, green: 73/255.0, blue: 55/255.0, alpha: 1)
    var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let statusManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
            return statusManager?.statusBarFrame.height ?? 20.0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }

    let stackHeight = 40
    lazy var iconImgView: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "album")
        return img
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
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
    
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = mainColor
        self.title = "以父之名"
        view.addSubview(iconImgView)
        view.addSubview(stackView)
        
        iconImgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([iconImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -statusBarHeight),
                                     iconImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                                     iconImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                                     iconImgView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)])
        
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: iconImgView.bottomAnchor, constant: 30),
                                     stackView.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)),stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
                                    )
        
        for index in 0...3 {
            let imageView = getControlButton(index: index)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            stackView.addArrangedSubview(imageView)
        }
    }
    
    func getControlButton(index:Int) -> UIImageView {
        let imgView = UIImageView(frame: .zero)
        imgView.image = UIImage(named: "icon\(index+1)")
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = CGFloat(stackHeight)/2.0
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
        view.layer.insertSublayer(gradientLayer, at: 0)

    }
}
