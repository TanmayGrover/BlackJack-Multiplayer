//
//  Singelton.swift
//  BlackJack
//
//  Created by Tanmay Grover on 2/28/15.
//  Copyright (c) 2015 Tanmay Grover. All rights reserved.
//
class Singelton {
    
    var noOfPlayers:Int = 0
    
    var startingBalance:Double = 0
    
    var noOfDecks:Int = 0
    
    class var sharedInstance: Singelton {
        
        struct Static {
            static let instance: Singelton = Singelton()
        }
        return Static.instance
    }
    
}