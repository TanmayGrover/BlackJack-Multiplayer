//
//  Card.swift
//  BlackJack
//
//  Created by Tanmay Grover on 2/16/15.
//  Copyright (c) 2015 Tanmay Grover. All rights reserved.
//

import Foundation



class Card {
    var rank : Rank
    var suit : Suit
    
    init( suit : Suit, rank : Rank){
        self.suit=suit
        self.rank=rank
        
    }
    
    func cardDescription()->String{
        return "The \(rank.cardDescription()) of  \(suit.cardDescription())"
    }
    
}



enum Suit : Int{
    case Spades, Hearts, Diamonds, Clubs
    
    func cardDescription() -> String{
        
        switch self{
        case .Spades :
            return "sapdes"
        case .Hearts :
            return "hearts"
        case .Clubs :
            return "Clubs"
        case .Diamonds :
            return "Diamonds"
        
        }
    }

}

enum Rank :Int{
    
    case Ace=1
    case Two  , Three , Four , Five, Six, Seven , Eight , Nine, Ten
    case Jack, Queen, King
    
    func cardDescription() -> String{
        switch self{
        case .Ace :
            return "ace"
        case .Jack:
            return "Jack"
        case .King:
            return "King"
        case .Queen:
            return "Queen"
            default:
            return String(self.rawValue)
        
        }
    }
        
    
}

