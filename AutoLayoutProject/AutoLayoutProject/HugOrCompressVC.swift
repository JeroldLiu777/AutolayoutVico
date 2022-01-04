//
//  hugOrCompress.swift
//  AutoLayoutProject
//
//  Created by Jerold Liu on 2021/11/16.
//

import Foundation
import UIKit

class HugOrCompressVC: BaseViewController {
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .yellow
        label.text = "这是一个抗压缩的label,这是一个非常非常这是一个非常非常大的label"
        label.textColor = .black
        return label
    }()

    lazy var subTitle: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .green
        label.text = "这是一个抗拉伸的label"
        label.textColor = .black
        return label
    }()
    
    
    
    lazy var compressContainer: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    lazy var hugContainer: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        view.addSubview(titleLabel)
        view.addSubview(subTitle)
        //case1 titleLabel 的左右约束故意设置为100, 原来的话,一旦内容比较多,肯定会被压缩, 但这时候设置左右约束等级小于251, 然后设置内容抗压缩,就能让内容正确显示出来, 这体现的是内容抗压缩等级高于外约束时候,对内容的作用. 观察内容是否被压缩就可以知道
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        
        let leftConstraint = titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50)
        leftConstraint.priority = .defaultLow
        leftConstraint.isActive = true
        
        let rightConstraint = titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        rightConstraint.isActive = true
        rightConstraint.priority = .defaultLow
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // case2 subtitle 的左右约束设置的很小,这时候,内容的抗拉伸约束很大,这样,label的内容就不会被拉伸了,观察背景色就可以知道没有被拉伸,抗拉伸有生效
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.setContentHuggingPriority(.required, for: .horizontal)
        subTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:20).isActive = true
        
        let leftConstraintOfSub = subTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        leftConstraintOfSub.priority = .defaultLow
        leftConstraintOfSub.isActive = true
        
        let rightContraintOfSub = subTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        rightContraintOfSub.priority = .defaultLow
        rightContraintOfSub.isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // 组合: 左边一个view内容抗压缩,当右边那个view非常大的时候,观察左边是否被压缩
        showAntiCompressCase()
        
        // 组合: 左边一个view内容抗拉伸,右边那个view非常小的时候,观察左边是否被拉伸
        showAntiHugCase()
    }
    
    func showAntiCompressCase() {
        let containerView = compressContainer
        view.addSubview(containerView)
        containerView.backgroundColor = .lightGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        let leftView = UILabel(frame: .zero)
        containerView.addSubview(leftView)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        leftView.backgroundColor = .blue
        leftView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        leftView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        leftView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        leftView.text = "我不想被压缩,别挤我了"
        leftView.textColor = .white
        
        let rightView = UILabel(frame: .zero)
        containerView.addSubview(rightView)
        rightView.backgroundColor = .purple
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        let rightViewLeadingAncor = rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 5)
        rightViewLeadingAncor.priority = .defaultLow
        rightViewLeadingAncor.isActive = true
        rightView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        rightView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        rightView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        rightView.text = "我非常非常长,你得让我挤挤,我就想要挤挤我很急急急急"
        rightView.textColor = .white
    }
    
    func showAntiHugCase() {
        let containerView = hugContainer
        view.addSubview(containerView)
        containerView.backgroundColor = .lightGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: compressContainer.bottomAnchor, constant: 20).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        let leftView = UILabel(frame: .zero)
        containerView.addSubview(leftView)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        leftView.backgroundColor = .blue
        leftView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        leftView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        leftView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        leftView.text = "我不想被拉伸,别拉我"
        leftView.textColor = .white
        
        let rightView = UILabel(frame: .zero)
        containerView.addSubview(rightView)
        rightView.backgroundColor = .purple
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        let rightViewLeadingAncor = rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 5)
        rightViewLeadingAncor.priority = .defaultLow
        rightViewLeadingAncor.isActive = true
        rightView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        rightView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        rightView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        rightView.text = "我很小只,我想拉你"
        rightView.textColor = .white
    }
}
