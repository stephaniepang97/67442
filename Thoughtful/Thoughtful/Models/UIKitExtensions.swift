//
//  UIKitExtensions.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/30/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation
import UIKit

// https://www.andrewcbancroft.com/2014/07/27/fade-in-out-animations-as-class-extensions-with-swift/
extension UIView {
	func fadeIn() {
		// Move our fade out code from earlier
		UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
			self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
		}, completion: nil)
	}
	
	func fadeOut() {
		UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
			self.alpha = 0.0
		}, completion: nil)
	}
	
	func slowIn() {
		// Move our fade out code from earlier
		UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
			self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
		}, completion: nil)
	}
	
	
	
	func slowOut() {
		UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
			self.alpha = 0.0
		}, completion: nil)
	}
}
