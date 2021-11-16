//
//  BaseViewController.swift
//  AutoLayoutProject
//
//  Created by Jerold Liu on 2021/11/16.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                view.backgroundColor = .black
            } else {
                view.backgroundColor = .white
            }
        }
    }
}
