//
//  AuthService.swift
//  VkApiV2
//
//  Created by Эдуард on 2/4/20.
//  Copyright © 2020 Eduard Ivash. All rights reserved.
//

import Foundation
import VKSdkFramework

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "7307867"
    private let vkSdk:VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeupSession() {
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
            } else {
                print("You have auth problems, state \(state) error \(String(describing:error))")
            }
        }
    }
    
    //MARK: VKSdkDelegate

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    //MARK:VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
