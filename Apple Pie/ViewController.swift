//
//  ViewController.swift
//  Apple Pie
//
//  Created by Mark Meretzky on 11/17/18.
//  Copyright © 2018 New York University School of Professional Studies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords: [String] = [
        "buccaneer",
        "swift",
        "glorious",
        "incandescent",
        "bug",
        "program"
    ];
    
    let incorrectMovesAllowed: Int = 7;
    var currentGame: Game!;
    
    var totalWins: Int = 0 {
        didSet {
            newRound();
        }
    }
    
    var totalLosses: Int = 0 {
        didSet {
            newRound();
        }
    }

    @IBOutlet weak var treeImageView: UIImageView!;
    @IBOutlet weak var correctWordLabel: UILabel!;
    @IBOutlet weak var scoreLabel: UILabel!;
    @IBOutlet var letterButtons: [UIButton]!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        newRound();   //Start the first game.
    }
    
    //Called by viewDidLoad, and at end of each game.
    
    func newRound() {
        if listOfWords.isEmpty {
            enableLetterButtons(false);
        } else {
            let newWord: String = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining:
                incorrectMovesAllowed, guessedLetters: [Character]());
            enableLetterButtons(true);
            updateUI();
        }
    }
    
    //Called by newRound.
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable;
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false;
        let letterString: String = sender.title(for: .normal)!;
        let letter: Character = Character(letterString.lowercased());
        currentGame.playerGuessed(letter: letter);
        updateGameState();
    }
    
    //Called only by buttonTapped.  If game is over, start a new one.
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1;  //Current game is over; no need to updateUI.
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1;    //Current game is over; no need to updateUI.
        } else {
            updateUI();        //Current game is not over.
        }
    }
    
    //Called by newRound and updateGameState.
    
    func updateUI() {
        /*
        var letters: [String] = [String]();
        for letter in currentGame.formattedWord {
            letters.append(String(letter));
        }
        */
        let letters: [String] = currentGame.formattedWord.map {String($0)} //simpler way
        let wordWithSpacing: String = letters.joined(separator: " ");
        correctWordLabel.text = wordWithSpacing;
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)";
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)");
    }
    
}

