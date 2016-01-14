//
//  MainViewController.swift
//  NetworkPut
//
//  Created by amela on 11/12/15.
//  Copyright © 2015 amela. All rights reserved.
//


import Foundation
import UIKit

class MainViewController: UIViewController {
    
    
    // MARK: - Def. Variables
    
    var state: String?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var openGarageButton: UIButton!
    
    @IBOutlet weak var closeGarageButton: UIButton!
    
    @IBOutlet weak var gpioStateLabel: UILabel!
    
    @IBOutlet weak var refreshStateButton: UIBarButtonItem!
    
    
    // MARK: - Main Button Actions
    
    @IBAction func refreshStateBAction(sender: UIBarButtonItem) {
        getState()
    }
    
    @IBAction func openGarageAction(sender: UIButton) {
        Request.sharedRequest.putData("0", myUrl: User.sharedUser.gpioUrl!, handler: {
            self.getState()
        })
    }
    
    //myUrl: User.sharedUser.gpioUrl!
    
    @IBAction func closeGarageAction(sender: UIButton) {
        Request.sharedRequest.putData("1", myUrl: User.sharedUser.gpioUrl!, handler: {
            self.getState()
        })
    }
    
    
    // MARK: - Handler
    
    func getState () -> Void {
        Request.sharedRequest.getData(User.sharedUser.gpioUrl!,  handler: {(result) -> Void in
            if let res = result {
                self.state = res
                dispatch_async(dispatch_get_main_queue()) {
                    self.gpioStateLabel.text = "State: " + self.state!
                }
    
                print(self.state)
            }
        })
    }
    
    
    // MARK: -  View Appearing Functions
    
    override func viewWillAppear(animated: Bool) {
        if User.sharedUser.gpioUrl == nil {
            openGarageButton.enabled = false
            closeGarageButton.enabled = false
            refreshStateButton.enabled = false
            
        } else {
            openGarageButton.enabled = true
            closeGarageButton.enabled = true
            refreshStateButton.enabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openGarageButton.layer.cornerRadius = 5
        closeGarageButton.layer.cornerRadius = 5
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageView.contentMode = .ScaleAspectFit
        
        let logo = UIImage(named: "logo.png")
        imageView.image = logo
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.frame.origin.y = 20
    }
}