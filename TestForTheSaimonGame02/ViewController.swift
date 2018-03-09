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
    
    //2. the score and round related varibals
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var numberOfRounds : Int = 0
    
    //3. other varibles related to logic in the game
    var randomNumber : Int = 0
    var computerFinishedPlaying = false
    
    //4. varibles related for playing the sounds
    var soundPlayer : AVAudioPlayer!
    var selectedSound : String = ""
    
    // the array that gives all the sound for the computer to play at the start of any Round
    var counterForComputerTurn: [Int] = [Int]()
    
    var gameStarted : Bool = false
    
                                //print("G- low, A-high, F-high, F- low, C-low")
    let soundsForSaimon = ["pianoHigh4", "pianoMidium2", "pianoMidium3", "pianoLow1"]
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //disable buttons
        button1.isEnabled = false;   button2.isEnabled = false;
        button3.isEnabled = false;   button4.isEnabled = false;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        //startButton.isEnabled = false
        startFirstRound()
    }
    
    
    func startFirstRound() {
        counterForComputerTurn.removeAll()
        randomNumber = Int(arc4random_uniform(4)+1)
        counterForComputerTurn.append(randomNumber)
        print(counterForComputerTurn)
        
        computerFinishedPlaying = true
        // need to call to the player turn insted!!
        playerTurn()
        //startNewRound(checkIfCompTurn: true)
    }
    
    // you need to call startNewRound after the start button was pressed and also when the user finished his turn
    func startNewRound(checkIfCompTurn: Bool) {
        
        // iterating trough the array of numbers genaretd for the computer
        for index in 0...numberOfRounds {
            activateButtonWithSound(inTheIndexOf: counterForComputerTurn[index])
            print(counterForComputerTurn)
            
            if index == numberOfRounds {
                computerFinishedPlaying = true
                print(numberOfRounds)
            }
        }
        numberOfRounds += 1
        playerTurn()
    }
    
    func playerTurn() {
        if computerFinishedPlaying == true {
            print(counterForComputerTurn.count)
            button1.isEnabled = true;   button2.isEnabled = true;
            button3.isEnabled = true;   button4.isEnabled = true;
            //TODO: Make a button pressed method that will have a counter and will check how many times the
            //TODO: player hit the buttons, the turn should move to the computer if the number of
            //TODO: repetitions isEqual to the computerTurnCounter or if there was a mistake
        }
    }
    
    func activateButtonWithSound(inTheIndexOf: Int) {
        if counterForComputerTurn.count == 1 {
            print("this is good \(counterForComputerTurn.count)")
        }
        counterForComputerTurn.append(Int(arc4random_uniform(4)+1))
        print("this is bad \(counterForComputerTurn.count)")
    }
    
    @IBAction func gamePlayButtonsPressed(_ sender: UIButton) {
        selectedSound = soundsForSaimon[sender.tag - 1]
        
        sender.showsTouchWhenHighlighted = true
        
//        sender.layer.shadowColor = UIColor.yellow.cgColor
//        sender.layer.shadowRadius = 10.0
//        sender.layer.shadowOpacity = 0.8
//        sender.layer.masksToBounds = false
        playSound()
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
    
    
    
    
    
    
    
    func startTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.gameStarted = false
        })
    }
    
    func startNewGame(){
        counterForComputerTurn.removeAll()
        setScore(scoreN: 0)
        setRound(roundNum: 1)
        startNextRound()
    }
    
    func setScore (scoreN: Int) {
        scoreLabel.text = "Score: \(scoreN)"
    }
    
    func setRound(roundNum: Int) {
        roundLabel.text = "Round: \(roundNum)"
    }
    
    
    func startNextRound(){
        //TODO: ArcForRandom number, append number to the array
        
        playNote(index: 0, toContinue: true)
    }
 
    
    func playNote(index: Int, toContinue: Bool){
        if index<0 {
            return
        } else if index>=counterForComputerTurn.count{
            return
        }
        
        //play
        
    }
    
    func endGame(){
        
    }
    
    
    
    
    
    
    
}

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
