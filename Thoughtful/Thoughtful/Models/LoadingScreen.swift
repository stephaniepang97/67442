//
//  LoadingScreen.swift
//  Thoughtful
//
//  Created by Alec Lam on 11/29/18.
//  Copyright © 2018 Stephanie Pang. All rights reserved.
//

import Foundation

class LoadingScreen {
	// based on the seconds
	public func calculateVisibleClouds(currentSeconds: Int) -> Int {
		let parseSeconds = currentSeconds % 9
		
		if (parseSeconds <= 2) {
			return 1
		}
		else if (parseSeconds <= 5) {
			return 2
		}
		else if (parseSeconds <= 8) {
			return 3
		}
		// default, should never happen
		else {
			return 0
		}
	}
	
}
