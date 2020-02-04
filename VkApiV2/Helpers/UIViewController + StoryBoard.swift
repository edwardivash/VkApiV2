//
//  UIViewController + StoryBoard.swift
//  VkApiV2
//
//  Created by Эдуард on 2/4/20.
//  Copyright © 2020 Eduard Ivash. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func loadFromStoryBoard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T  {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard!")
        }
    }
}
