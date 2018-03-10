//
//  ViewController.swift
//  TestForTheSaimonGame02
//
//  Created by Ishay on 3/6/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //1. all of the saimon playing buttons
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    //2. the score lives and round related varibals

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    var numberOfRounds : Int = 0
    var scoreNumber : Int = 0
    var numberOflives = 3
    
    //3. other varibles related to logic in the game
    var randomNumber : Int = 0
    var computerFinishedPlaying = false
    
    //4. varibles related for playing the sounds
    var soundPlayer : AVAudioPlayer!
    var selectedSound : String = ""
    
    // the array that gives all the sound for the computer to play at the start of any Round
    var counterForComputerTurn: [Int] = [Int]()
    var counterForPlayerTurn: [Int] = [Int]()
    
                                //print("G- low, A-high, F-high, F- low, C-low")
    let soundsForSaimon = ["pianoHigh4", "pianoMidium2", "pianoMidium3", "pianoLow1"]
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //disable buttons
        changeThePlayButtons(isEnabledStatus: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func changeThePlayButtons(isEnabledStatus: Bool){
        button1.isEnabled = isEnabledStatus;   button2.isEnabled = isEnabledStatus;
        button3.isEnabled = isEnabledStatus;   button4.isEnabled = isEnabledStatus;
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        startButton.isEnabled = false
        counterForComputerTurn.removeAll()
        numberOflives = 3
        startNewRound()
    }
    
    // you need to call startNewRound after the start button was pressed and also when the user finished his turn
    func startNewRound() {
        computerFinishedPlaying = false
        counterForPlayerTurn.removeAll()
        
        self.randomNumber = Int(arc4random_uniform(4)+1)
        self.counterForComputerTurn.append(self.randomNumber)
        print(self.counterForComputerTurn)
        //print(self.counterForComputerTurn.count)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//        })
        
        for index in 0...numberOfRounds {
            if index == numberOfRounds {
                computerFinishedPlaying = true
            }
        }
        numberOfRounds += 1
        playerTurn()
    }
    
    func playerTurn() {
        if computerFinishedPlaying == true {
            changeThePlayButtons(isEnabledStatus: true)
        }
    }
    
    @IBAction func saimonPlayButtonsPressed(_ sender: UIButton) {
        selectedSound = soundsForSaimon[sender.tag - 1]
        counterForPlayerTurn.append(sender.tag)
        
        for index in counterForPlayerTurn.count-1...counterForPlayerTurn.count-1{
            
                if counterForPlayerTurn[index] == counterForComputerTurn[index] {
                    print("you are right")
                    scoreNumber = scoreNumber + 5 + 2 * numberOfRounds
                    updateUI()
                    print(scoreNumber)
                } else {
                    print("you are wrong")
                    numberOflives -= 1
                    scoreNumber = scoreNumber - 5
                    updateUI()
                    print(scoreNumber)
                    if numberOflives == 0 {
                        gameOver()
                    }
                    break
                }
        }
        ////TODO: animate
//        sender.showsTouchWhenHighlighted = true // make it work as a shodowChangingMethod
        sender.layer.shadowColor = UIColor.white.cgColor
        sender.layer.shadowRadius = 10.0
        sender.layer.shadowOpacity = 0.8
        sender.layer.masksToBounds = false
        playSound()
        /////
        
        if counterForPlayerTurn.count == counterForComputerTurn.count {
            startNewRound()
        }
    }
    
    
    
    func playSound(){
        let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "wav")
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        soundPlayer.play()
    }
    
    func updateUI(){
        roundLabel.text = "Rounds = \(numberOfRounds)"
        scoreLabel.text = "score = \(scoreNumber)"
        livesLabel.text = "Lives = \(numberOflives)"
    }
    
    func gameOver() {
        print("GAME OVER!!")
        //dont know why it's not working"
//        changeThePlayButtons(isEnabledStatus: false)
//        startButton.isEnabled = true
    }
}



//func startTimer() {
//    //
//}
//        sender.layer.shadowColor = UIColor.yellow.cgColor
//        sender.layer.shadowRadius = 10.0
//        sender.layer.shadowOpacity = 0.8
//        sender.layer.masksToBounds = false


// make this function have a for loop from 0 till computre array.count and have an index which run in both
//computerArray and in the PlayerArray and check for each element in the index place for equality
//if it's not equal then the loops break's and it's game over. if it's ok it's run while the counters.count is different
//TODO: Make a button pressed method that will have a counter and will check how many times the
//TODO: player hit the buttons, the turn should move to the computer if the number of
//TODO: repetitions isEqual to the computerTurnCounter or if there was a mistake



//TODO: 1. after the computer finished runnig over his array the bool need to change to true
//TODO: 2. then a method for the playerTurn should be call
//TODO: 3. the method should check if the computer finished his turn
//TODO: 4. if the bool is set to true then all the buttons(beside the startNewGame) should be turn back to Enable
//TODO: 5. then there should be a start for a timer with one minute for each button press
//TODO: 6. after one minute without a press you should get game over
//TODO: 7. make a counter var to know where exectly the player is in the gameArray
//TODO: 8. the couner should show the place in the array -1(cos arrays start from 0)
//TODO: 9. after each press by the player there should be a method call to check if he answered right or wrong
//TODO: 10. this method should check the corrent index for the player with the same index in the computerArray
//TODO: 11. if the number is eqoual in the two arrays then he ansawered right and there should be a counter++
//TODO: 12. if he was wrong then there should be a popup with game over and start new game
//TODO: 13. the start new game should have should be calling the startNewGame method
//TODO: 14. there should be 2 more buttons, 1 for highScore, 2 To quiet the app
