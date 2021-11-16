//
//  hugOrCompress.swift
//  AutoLayoutProject
//
//  Created by Jerold Liu on 2021/11/16.
//

import Foundation
import UIKit

class HugOrCompressVC: UIViewController {
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .yellow
        label.text = "这是一个抗压缩的label,这是一个非常非常这是一个非常非常这是一个非常非常这是一个非常非常这是一个非常非常"
        return label
    }()

    lazy var subTitle: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .green
        label.text = "这是一个抗拉伸的label"
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subTitle)
        //case1 titleLabel 的左右约束故意设置为100, 一旦内容比较多,就会被压缩在一起, 这时候设置左右约束等级小于251, 然后设置内容抗压缩,就能让内容正确显示出来
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        let leftConstraint = titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100)
        leftConstraint.priority = .defaultLow
        leftConstraint.isActive = true
        let rightConstraint = titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100)
        rightConstraint.isActive = true
        rightConstraint.priority = .defaultLow
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        // case2 subtitle 的左右约束设置的很小,这时候,内容的抗拉伸约束很大,这样,label的内容就不会被拉伸了
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.setContentHuggingPriority(.required, for: .horizontal)
        subTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:50).isActive = true
        
        let leftConstraintOfSub = subTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        leftConstraintOfSub.priority = .defaultLow
        leftConstraintOfSub.isActive = true
        let rightContraintOfSub = subTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        rightContraintOfSub.priority = .defaultLow
        rightContraintOfSub.isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
    }
}
