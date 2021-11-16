//
//  ViewController.swift
//  AutoLayoutProject
//
//  Created by Jerold Liu on 2021/11/2.
//



/** priorty instructions
 @available(iOS 6.0, *)
 public static let required: UILayoutPriority

 @available(iOS 6.0, *)
 public static let defaultHigh: UILayoutPriority // This is the priority level with which a button resists compressing its content.

 public static let dragThatCanResizeScene: UILayoutPriority // This is the appropriate priority level for a drag that may end up resizing the window's scene.

 public static let sceneSizeStayPut: UILayoutPriority // This is the priority level at which the window's scene prefers to stay the same size.  It's generally not appropriate to make a constraint at exactly this priority. You want to be higher or lower.

 public static let dragThatCannotResizeScene: UILayoutPriority // This is the priority level at which a split view divider, say, is dragged.  It won't resize the window's scene.

 @available(iOS 6.0, *)
 public static let defaultLow: UILayoutPriority // This is the priority level at which a button hugs its contents horizontally.

 @available(iOS 6.0, *)
 public static let fittingSizeLevel: UILayoutPriority // When you send -[UIView systemLayoutSizeFittingSize:], the size fitting most closely to the target size (the argument) is computed.  UILayoutPriorityFittingSizeLevel is the priority level with which the view wants to conform to the target size in that computation.  It's quite low.  It is generally not appropriate to make a constraint at exactly this priority.  You want to be higher or lower.
 */

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var hugOrCompressButton: UIButton!
    @IBOutlet weak var samplePresentButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func clickHugOrCompress(_ sender: Any) {
        let hugOrCompressVC = HugOrCompressVC()
        navigationController?.pushViewController(hugOrCompressVC, animated: true)
    }
    
    @IBAction func clickSamplePresent(_ sender: Any) {
        let samplePresent = SamplePresentVC()
        navigationController?.pushViewController(samplePresent, animated: true)
    }
    
}

