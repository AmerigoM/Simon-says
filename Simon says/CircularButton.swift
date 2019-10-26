//
//  CircularButton.swift
//  Simon says
//
//  Created by Amerigo Mancino on 26/10/2019.
//  Copyright © 2019 Amerigo Mancino. All rights reserved.
//

import UIKit

/* Class representing a circular button in the UI element */
class CircularButton: UIButton {

    // since we don't have access to the viewDidLoad method, we
    // have to use the corresponding function for UI elements
    override func awakeFromNib() {
         super.awakeFromNib()
        
        // make sure the button is circular
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
    }
    
    // computed property that modify the alpha value
    // and gives the buttons an animation when thy are touched
    override var isHighlighted: Bool {
        // every time this property is set (which happens
        // when the user taps on a button)...
        didSet {
            if isHighlighted {
                alpha = 1.0
            } else {
                alpha = 0.5
            }
        }
    }

}
