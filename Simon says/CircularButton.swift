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
        // make sure the button is circular
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
    }

}
