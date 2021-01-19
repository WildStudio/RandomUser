//
//  AlertControllerDisplayer.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit

protocol AlertControllerDisplayer {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
}

extension AlertControllerDisplayer where Self: UIViewController {
    
    func displayAlert(
        with title: String,
        message: String,
        actions: [UIAlertAction]? = nil
    ) {
        guard presentedViewController == nil
            else { return }
        
        let alertController = UIAlertController(
            title: title, message: message,
            preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
    
}
