//
//  Deck.swift
//  BlackJack
//
//  Created by Tanmay Grover on 2/16/15.
//  Copyright (c) 2015 Tanmay Grover. All rights reserved.
//

import Foundation



class Deck {
    var cards : [Card] = []
    
    
    func shuffleCards(){
        
    
        for var s = 0; s < 4; s++ {
            for var r = 1 ; r < 13 ; r++ {
                
                cards.append(Card(suit:Suit[s], rank: r))
                }
        }
    }
    
    
}




