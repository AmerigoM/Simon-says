//
//  ViewController.swift
//  Simon says
//
//  Created by Amerigo Mancino on 26/10/2019.
//  Copyright © 2019 Amerigo Mancino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorButtons: [CircularButton]!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet var playerLabels: [UILabel]!
    @IBOutlet var scoreLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // order the colorButtons array by tag
        colorButtons = colorButtons.sorted(by: { (btn1, btn2) -> Bool in
            btn1.tag < btn2.tag
        })
        
        // order the player label array by tag
        playerLabels = playerLabels.sorted(by: { (lab1, lab2) -> Bool in
            lab1.tag < lab2.tag
        })
        
        // order the scoreLabel array by tag
        scoreLabels = scoreLabels.sorted(by: { (lab1, lab2) -> Bool in
            lab1.tag < lab2.tag
        })
        
        // create a new game
        createNewGame()
    }

    @IBAction func colorButtonHandler(_ sender: CircularButton) {
        print("Button \(sender.tag) tapped!")
    }
    
    @IBAction func actionButtonHandler(_ sender: UIButton) {
        print("Action Button")
    }
    
    func createNewGame() {
        // change the action button text
        actionButton.setTitle("Start Game", for: .normal)
        
        // reduce the opacity of all the color buttons
        for button in colorButtons {
            button.alpha = 0.5
        }
    }
}

