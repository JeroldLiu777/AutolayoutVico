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
    func addItemsToBottomStack(itemType: BottomStackViewItems) {
        switch itemType {
        case .cycle:
            let imageView = getCommonButton(imageName: "cycleplay")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            stackViewBottom.addArrangedSubview(imageView)
        case .next,.play,.previous:
            let imageView = getControlButton(index: itemType.rawValue,iconNamePrefix: "play",cornerRadius: stackHeight/2, backColor: nil)
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

class SamplePresentVC: BaseViewController {
    
    lazy var backgroundImgView: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "album")
        return img
    }()
    
    lazy var stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 100
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var stackViewTop: UIStackView = {
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
    
    lazy var stackViewSlide: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.center = self.view.center
        slider.minimumValue = 0  //最小值
        slider.maximumValue = 1  //最大值
        slider.value = 0.3  //当前默认值
        slider.minimumTrackTintColor = UIColor.white
        slider.maximumTrackTintColor = subColor
        return slider
    }()
    
    lazy var timeLabelLeft: UILabel = {
        let label = UILabel()
        label.text = "01:26"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var timeLabelRight: UILabel = {
        let label = UILabel()
        label.text = "05:26"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    
    var backgroundImgTopConstraint:NSLayoutConstraint?
    
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
        guard let tempConstraint = backgroundImgTopConstraint else { return }
        if size.width > size.height {
            // 横屏
            stackViewTop.spacing = 50
            tempConstraint.constant = 0
            stackViewContainer.spacing = 10
            stackViewBottom.spacing = 50
        } else {
            // 竖屏
            stackViewTop.spacing = 30
            tempConstraint.constant = -(44+statusBarHeight)
            stackViewContainer.spacing = 100
            stackViewBottom.spacing = 20
        }
    }
    
    
    
    func setupUI() {
        view.backgroundColor = mainColor
        view.addSubview(stackViewContainer)
        view.addSubview(backgroundImgView)
        
        // background image view
        backgroundImgView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImgTopConstraint = backgroundImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -statusBarHeight)
        guard let tempConstraint = backgroundImgTopConstraint else { return }
        NSLayoutConstraint.activate([tempConstraint,
                                     backgroundImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                                     backgroundImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                                     backgroundImgView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)])
        
        // navigation bar
        setupNavigationBar()
        
        // container
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.topAnchor.constraint(equalTo: backgroundImgView.bottomAnchor, constant: 20).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // stack top
        stackViewContainer.addArrangedSubview(stackViewTop)
        stackViewTop.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackViewTop.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight))]
                                    )
        
        for index in 0...3 {
            let imageView = getControlButton(index: index+1,iconNamePrefix: "icon",cornerRadius: 10, backColor: subColor)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(stackHeight)).isActive = true
            stackViewTop.addArrangedSubview(imageView)
        }
        
        // stack slider
        stackViewContainer.addArrangedSubview(stackViewSlide)
        stackViewSlide.translatesAutoresizingMaskIntoConstraints = false
        stackViewSlide.heightAnchor.constraint(equalToConstant: statusBarHeight).isActive = true
        stackViewSlide.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor, constant: 20).isActive = true
        stackViewSlide.trailingAnchor.constraint(equalTo: stackViewContainer.trailingAnchor, constant: -20).isActive = true
        
        
        timeLabelLeft.translatesAutoresizingMaskIntoConstraints = false
        timeLabelLeft.setContentCompressionResistancePriority(.required, for: .horizontal)
        timeLabelLeft.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackViewSlide.addArrangedSubview(timeLabelLeft)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        let slideWidthAnchor = slider.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 80)
        slideWidthAnchor.priority = .defaultLow
        slideWidthAnchor.isActive = true
        stackViewSlide.addArrangedSubview(slider)
        
        timeLabelRight.translatesAutoresizingMaskIntoConstraints = false
        timeLabelRight.setContentHuggingPriority(.required, for: .horizontal)
        timeLabelRight.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackViewSlide.addArrangedSubview(timeLabelRight)
        
        
        // stack bottom
        stackViewContainer.addArrangedSubview(stackViewBottom)
        stackViewBottom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackViewBottom.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight))])
        for bottomItem in BottomStackViewItems.allCases {
            addItemsToBottomStack(itemType: bottomItem)
        }
    }
    
    func getCommonButton(imageName: String) -> UIImageView {
        let imgView = UIImageView(frame: .zero)
        imgView.image = UIImage(named: imageName)
        return imgView
    }
    
    func getControlButton(index:Int, iconNamePrefix: String, cornerRadius: CGFloat, backColor: UIColor?) -> UIImageView {
        let imgView = UIImageView(frame: .zero)
        imgView.image = UIImage(named: "\(iconNamePrefix)\(index)")
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = cornerRadius
        imgView.backgroundColor = backColor
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
