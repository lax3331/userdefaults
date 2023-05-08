//
//  ViewController.swift
//  userdefaults
//
//  Created by Nikita Kuznetsov on 07.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }

    private func setup() {
        if Model.themeValue == true {
            view.backgroundColor = .darkGray
        } else {
            view.backgroundColor = .white
        }
        dataLabel.font = UIFont.systemFont(ofSize: Model.stepperValue)
    }
}

