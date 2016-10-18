//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Greg Mor Bacskai on 16/10/16.
//  Copyright © 2016 bacskai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var activePlayer = 1
    var activeGame = true
    var gameState = [0,0,0,0,0,0,0,0,0]
    
    @IBOutlet weak var winnerView: UIView!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerView.layer.cornerRadius = 20
        winnerView.clipsToBounds = true
    }
    
    func presentWinner(name: String){
        winnerLabel.text = "\(name) has won!"
        winnerView.isHidden = false
        winnerLabel.isHidden = false
        playAgainBtn.isHidden = false
        
        winnerLabel.center = CGPoint(x: self.winnerLabel.center.x-500, y: winnerLabel.center.y)
        winnerView.center = CGPoint(x: self.winnerView.center.x-500, y: winnerView.center.y)
        playAgainBtn.center = CGPoint(x: self.playAgainBtn.center.x-500, y: playAgainBtn.center.y)
        
        UIView.animate(withDuration: 1){
            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x+500, y: self.winnerLabel.center.y)
            self.winnerView.center = CGPoint(x: self.winnerView.center.x+500, y: self.winnerView.center.y)
            self.playAgainBtn.center = CGPoint(x: self.playAgainBtn.center.x+500, y: self.playAgainBtn.center.y)
        }
    }
    
    func newGame(){
        winnerLabel.isHidden = true
        winnerView.isHidden = true
        playAgainBtn.isHidden = true
        
        activePlayer = 1
        activeGame = true
        gameState = [0,0,0,0,0,0,0,0,0]
        
        var button: UIButton
        for i in 1...9 {
            button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: [])
        }
    }
    
    @IBAction func playAgainPressed(_ sender: AnyObject) {
        newGame()
    }

    @IBAction func buttonPressed(_ sender: AnyObject) {
        let activePosition = sender.tag - 1
        if gameState[activePosition] == 0 && activeGame {
            gameState[activePosition] = activePlayer
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
            }
            else{
                sender.setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
            }
            
            for combination in winningCombinations{
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[0]] == gameState[combination[2]]{
                    
                    activeGame = false
                    let winner = activePlayer == 1 ? "Crosses" : "Noughts"
                    presentWinner(name: winner)
                    
                }
            }
            //game drawn
            if(activeGame){
                if !gameState.contains(0){
                    activeGame = false
                    let winner = "Nobody"
                    presentWinner(name: winner)
                }
            }
        }
    }
}
