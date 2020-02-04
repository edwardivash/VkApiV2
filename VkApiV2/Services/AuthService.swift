//
//  AuthService.swift
//  VkApiV2
//
//  Created by Эдуард on 2/4/20.
//  Copyright © 2020 Eduard Ivash. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController:UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "7307867"
    private let vkSdk:VKSdk
    
    weak var delegator:AuthServiceDelegate?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeupSession() {
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { [delegator] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                delegator?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("You have auth problems, state \(state) error \(String(describing:error))")
                delegator?.authServiceDidSignInFail()
            }
        }
    }
    
    //MARK: VKSdkDelegate

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegator?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    //MARK:VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegator?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
