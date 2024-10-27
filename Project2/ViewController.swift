//
//  ViewController.swift
//  Project2
//
//  Created by Maksim Li on 15/09/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        button1.clipsToBounds = true
        button2.clipsToBounds = true
        button3.clipsToBounds = true
                
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
         
        
        title = "\(countries[correctAnswer].uppercased()) | Your score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Wrong"
            score -= 1
            message = "That’s the flag of \(countries[sender.tag].uppercased()) \n Your score is \(score)"
        }
        
        questionsAsked += 1
            print("Questions asked: \(questionsAsked)")
        
            let ac: UIAlertController
            
        if score == 10 {
                print("Game Over condition triggered (score)")
                ac = UIAlertController(title: "Game Over", message: "Congratulations, you scored 10 points!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
                    self.score = 0
                    self.questionsAsked = 0
                    self.askQuestion()
                }))
            } else if questionsAsked == 10 {
                print("Game Over condition triggered (questions asked)")
                ac = UIAlertController(title: "Game Over", message: "Your final score is \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
                    self.score = 0
                    self.questionsAsked = 0
                    self.askQuestion()
                }))
            } else {
                ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            }
            
            present(ac, animated: true)
    }
    
    @objc func showScore() {
        let scoreMessage = "Your current score is \(score)"
        let ac = UIAlertController (title: "Score", message: scoreMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    
    
}
