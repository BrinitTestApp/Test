//
//  ViewControllerExtension.swift
//  Test
//
//  Created by Brinit on 12/09/25.
//

import UIKit

    
    extension UIViewController {
        func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    }
