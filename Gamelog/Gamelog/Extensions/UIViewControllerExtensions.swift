//
//  UIViewControllerExtensions.swift
//  Gamelog
//
//  Created by yxgg on 24/04/22.
//

import Foundation
import UIKit

extension UIViewController {
  func presentAlert(title: String?, message: String?, completion: @escaping (UIAlertAction) -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
    present(alert, animated: true)
  }
}

extension UIView {
  var superCollectionView: UICollectionView? {
    if let superview = superview {
      if superview is UICollectionView {
        return superview as? UICollectionView
      } else {
        return superview.superCollectionView
      }
    }
    return nil
  }
}
