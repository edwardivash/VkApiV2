//
//  AuthViewController.swift
//  VkApiV2
//
//  Created by Эдуард on 2/4/20.
//  Copyright © 2020 Eduard Ivash. All rights reserved.
//

import UIKit
import VKSdkFramework

class AuthViewController: UIViewController {

    private var authService:AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authService = AppDelegate.shared().authService
    }

    
    @IBAction func signInButton(_ sender: UIButton) {
        authService.wakeupSession()
    }
    
}
