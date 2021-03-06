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
    
    var currentPlayer = 0
    var scores = [0,0]
    
    var sequenceIndex = 0
    var colorSequence = [Int]()
    var colorsToTap = [Int]()
    
    // it is set to true only when the game is finished (aka the player makes a mistake)
    var gameEnded = false
    
    //MARK: - Override methods
    
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
    
    // invoked anytime there is a touch on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameEnded {
            gameEnded = false
            createNewGame()
        }
    }
    
    // MARK: - IBAction methods

    @IBAction func colorButtonHandler(_ sender: CircularButton) {
        // check if the user tapped the correct button
        
        // check if the sender tag is equal to the tag of the first element of
        // the sequence of colorsToTap and remove the element thereafter
        if sender.tag == colorsToTap.removeFirst() {
            
        } else {
            // wrong button tapped
            for button in colorButtons {
                button.isEnabled = false
            }
            
            endGame()
            return
        }
        
        // we tapped all the colors in the sequence and colorsToTap is empty
        if colorsToTap.isEmpty {
            for button in colorButtons {
                button.isEnabled = false
            }
            
            scores[currentPlayer] += 1
            updateScoreLabels()
            switchPlayers()
            
            actionButton.setTitle("Continue", for: .normal)
            actionButton.isEnabled = true
        }
    }
    
    // The "Start Game" button gets pressed
    @IBAction func actionButtonHandler(_ sender: UIButton) {
        sequenceIndex = 0
        actionButton.setTitle("Memorize!", for: .normal)
        actionButton.isEnabled = false
        
        // the sequence starts playing and we do want to ignore all the user taps
        view.isUserInteractionEnabled = false
        
        addNewColor()
        
        // after one second we will start playing the sequence
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.playSequence()
        }
    }
    
    // MARK: - Supporting functions
    
    func createNewGame() {
        // change the action button text
        actionButton.setTitle("Start Game", for: .normal)
        
        // reduce the opacity of all the color buttons and disable them
        for button in colorButtons {
            button.alpha = 0.5
            button.isEnabled = false
        }
        
        // at the beginning, the start button can be clicked
        actionButton.isEnabled = true
        
        // at the beginning, there is no sequence
        colorSequence.removeAll()
        
        // empty the players properties
        currentPlayer = 0
        scores = [0,0]
        
        // enlight the current player that must start playing
        playerLabels[currentPlayer].alpha = 1.0
        playerLabels[1].alpha = 0.75
        
        updateScoreLabels()
    }
    
    func updateScoreLabels() {
        for (index, label) in scoreLabels.enumerated() {
            label.text = "\(scores[index])"
        }
    }
    
    func addNewColor() {
        colorSequence.append(Int.random(in: 0...3))
    }
    
    func playSequence() {
        if sequenceIndex < colorSequence.count {
            flash(btn: colorButtons[colorSequence[sequenceIndex]])
            sequenceIndex += 1
        } else {
            // the sequence finished playing
            colorsToTap = colorSequence
            view.isUserInteractionEnabled = true
            actionButton.setTitle("Tap the circles!", for: .normal)
            
            for button in colorButtons {
                button.isEnabled = true
            }
        }
    }
    
    func flash(btn: CircularButton) {
        UIView.animate(withDuration: 0.5, animations: {
            btn.alpha = 1.0
            btn.alpha = 0.5
        }) { (bool) in
            self.playSequence()
        }
    }
    
    func switchPlayers() {
        playerLabels[currentPlayer].alpha = 0.75
        currentPlayer = currentPlayer == 0 ? 1 : 0
        playerLabels[currentPlayer].alpha = 1.0
    }
    
    func endGame() {
        let message = currentPlayer == 0 ? "Player 2 wins" : "Player 1 wins"
        actionButton.setTitle(message, for: .normal)
        gameEnded = true
    }
}

