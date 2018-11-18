//
//  Game.swift
//  Apple Pie
//
//  Created by Mark Meretzky on 11/18/18.
//  Copyright © 2018 New York University School of Professional Studies. All rights reserved.
//

import Foundation;

struct Game {
    let word: String;
    var incorrectMovesRemaining: Int;
    var guessedLetters: [Character];
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter);
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1;
        }
    }
    
    var formattedWord: String {
        var guessedWord: String = "";
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)";
            } else {
                guessedWord += "_";
            }
        }
        return guessedWord;
    }
};
