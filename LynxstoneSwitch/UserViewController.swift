//
//  UserViewController.swift
//  NetworkPut
//
//  Created by amela on 27/11/15.
//  Copyright © 2015 amela. All rights reserved.
//

import Foundation
import UIKit

class UserViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwdTextField: UITextField!
    
    @IBOutlet weak var hostTextField: UITextField!
    
    @IBOutlet weak var portTextField: UITextField!
    
    @IBOutlet weak var gpioTextField: UITextField!
    
    @IBOutlet weak var urlLabel: UILabel!
    
    @IBOutlet weak var userSwitch: UISwitch!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    // MARK: - Actions
    
    @IBAction func userSwitch(sender: UISwitch) {
        refreshStateLabel()
        
        if sender.on {
            userNameTextField.enabled = true
            passwdTextField.enabled = true
            
        } else {
            userNameTextField.enabled = false
            passwdTextField.enabled = false
        }
    }
    
    @IBAction func saveAction(sender: UIBarButtonItem) {
        if userNameTextField.text != "" && hostTextField.text != nil && hostTextField.text != "" && portTextField.text != "" && gpioTextField.text != "" {
            saveUser()
            
        } else if hostTextField.text != "" && portTextField.text != "" && gpioTextField.text != "" {
            saveUser()
        }

    }
    
    
    // MARK: - Saving
    
    func saveUser () {
        User.sharedUser.name = userNameTextField.text
        User.sharedUser.password = passwdTextField.text
        
        User.sharedUser.host.host = hostTextField.text
        User.sharedUser.host.port = portTextField.text
        User.sharedUser.gpios = gpioTextField.text
        
        User.sharedUser.gpioUrl = urlLabel.text
        print(User.sharedUser.gpioUrl)
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(User.sharedUser)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "User")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        print("User Saved")
    }
    
    // MARK: - Text Field Delegate
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        refreshStateLabel()
        view.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        refreshStateLabel()
        view.endEditing(true)
        return true
    }
    
    func refreshStateLabel () {
        if userSwitch.on {
            let urlEnd = gpioTextField.text!
            let user = userNameTextField.text! + ":" + passwdTextField.text! + "@"
            urlLabel.text = "https://" + user + hostTextField.text! + ":" + portTextField.text! + urlEnd
        }
        else {
            let urlEnd = gpioTextField.text!
            urlLabel.text = "https://" + hostTextField.text! + ":" + portTextField.text! + urlEnd
        }

    }
    
    
    // MARK: -  View Appearing Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNameTextField.delegate = self
        self.passwdTextField.delegate = self
        self.hostTextField.delegate = self
        self.portTextField.delegate = self
        self.gpioTextField.delegate = self
        
        if !userSwitch.on {
            userNameTextField.enabled = false
            passwdTextField.enabled = false
        } else {
            userNameTextField.enabled = true
            passwdTextField.enabled = true
        }
        
        print(User.sharedUser.gpios)
        userNameTextField.text = User.sharedUser.name
        passwdTextField.text = User.sharedUser.password
        hostTextField.text = User.sharedUser.host.host
        portTextField.text = User.sharedUser.host.port
        gpioTextField.text = User.sharedUser.gpios
        urlLabel.text = User.sharedUser.gpioUrl
    }
}