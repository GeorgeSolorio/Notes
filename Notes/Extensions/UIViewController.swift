//
//  UIViewController.swift
//  Notes
//
//  Created by George Solorio on 11/8/20.
//

import UIKit

extension UIViewController {
   
   func showAlert(with title: String?, and message: String?) {
      
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      
      let ok = UIAlertAction(title: "OK", style: .default)
      
      alert.addAction(ok)
   
      present(alert, animated: true)
   }
}
