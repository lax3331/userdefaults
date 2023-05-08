//
//  SettingsViewController.swift
//  userdefaults
//
//  Created by Nikita Kuznetsov on 07.05.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private enum Const: Double {
        case min = 15.0
        case max = 25.0
    }
    
    @IBOutlet weak var ThemeSwitcher: UISwitch! {
        didSet {
            ThemeSwitcher.isOn = Model.themeValue
        }
    }
    @IBOutlet weak var CurrentFontLabel: UILabel! {
        didSet {
            CurrentFontLabel.text = String(Int(Model.stepperValue))
        }
    }
    @IBOutlet weak var FontStepper: UIStepper! {
        didSet {
            FontStepper.minimumValue = Const.min.rawValue
            FontStepper.maximumValue = Const.max.rawValue
            FontStepper.value = Model.stepperValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        Model.stepperValue = sender.value
        CurrentFontLabel.text = String(Int(Model.stepperValue))
    }
    
    @IBAction func themeChanger(_ sender: UISwitch) {
        Model.themeValue = ThemeSwitcher.isOn
        setup()
    }
    
    private func setup() {
        if Model.themeValue == true {
            view.backgroundColor = .darkGray
        } else {
            view.backgroundColor = .white
        }
    
    }
}
