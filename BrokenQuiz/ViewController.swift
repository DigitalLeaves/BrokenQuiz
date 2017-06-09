//
//  ViewController.swift
//  BrokenQuiz
//
//  Created by Ignacio Nieto Carvajal on 9/6/17.
//  Copyright © 2017 Digital Leaves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var checkResponseButton: UIButton!

    // data
    var number1: Int!
    var number2: Int!
    var userHasAnswered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update UI
        containerView.layer.cornerRadius = 6.0
        checkResponseButton.layer.cornerRadius = 6.0
        
        // Start game
        generateQuiz()
    }

    func generateQuiz() {
        // generate two random numbers
        number1 = Int(arc4random_uniform(10)) + 1
        number2 = Int(arc4random_uniform(10)) + 1

        // update UI
        answerTextField.text = ""
        quizLabel.text = "How much is \(number1!) + \(number2!)?"
        checkResponseButton.setTitle("Check response", for: .normal)
    }
    
    func checkQuiz(_ response: String) {
        // first, parse the response string as an int
        
        // BUG 1. Parsing an integer will return nil if the string is not a number.
        let responseAsNumber = Int(response)!
        /* SOLUTION 1. Check that the answer is actually a number
        guard let responseAsNumber = Int(response) else {
            quizLabel.text = "Sorry, that was not even a number! 😱"
            checkResponseButton.setTitle("Play again!", for: .normal)
            return
        }
         */
        
        // then, check it.
        // BUG 2. We did a mistake in the operation, the result is not calculated correctly
        if responseAsNumber == number1 - number2 { // win!
        // SOLUTION 2. Fix the calculation: 
        // if responseAsNumber == number1 + number2 { // win!
            quizLabel.text = "Congratulations! You win! 🎉🎉🎉"
        } else { // loose!
            quizLabel.text = "Sorry, the right answer was \(number1 + number2)... 😓"
        }
        
        // update UI
        checkResponseButton.setTitle("Play again!", for: .normal)
    }
    
    @IBAction func checkResponse(_ sender: Any) {
        if answerTextField.text == nil || answerTextField.text!.characters.count < 1 { return }
        
        if userHasAnswered { // reset quiz
            generateQuiz()
        } else { // check response
            checkQuiz(answerTextField.text!)
        }
        
        userHasAnswered = !userHasAnswered
        answerTextField.isHidden = userHasAnswered
    }

}

