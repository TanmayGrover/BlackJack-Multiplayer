//
//  ViewController.swift
//  BlackJack
//
//  Created by Tanmay Grover on 2/17/15.
//  Copyright (c) 2015 Tanmay Grover. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dealerCard: UILabel!
    @IBOutlet weak var foldCard: UILabel!
    
    @IBOutlet weak var roundCount: UILabel!
    
    
    @IBOutlet weak var cardTotal: UILabel!
    @IBOutlet weak var playerCard2: UILabel!
    
    let logic = Logic()
    var d = Dealer()
    var num=0
    var initialMoney = 100
    
    @IBAction func deckCreate(sender: AnyObject) {
        if num == 0 {
        d.dealCard()
        d.shuffle()
        }
        else{
        println("You cannot shuffle before 5 rounds")
        }
        
    }
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var playerCard: UILabel!
    
    
    @IBAction func standPlayer(sender: AnyObject) {
        sender.sender
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialPlayerCard()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func standPressed(sender: AnyObject) {
        moneyLabel.text = "Hello World"
        logic.initialPlayerCard()
        
        //moneyLabel.text =
    }
    
    var card1Value = 0
    var card2Value = 0
    var cardTotalValue = 0
    
    @IBAction func dealCards(sender: AnyObject) {
        num++
        if num  >= 5 {
            self.num = 0
        }
        roundCount.text = "\(num)"
        
        card1Value = d.getCard1Player()
         card2Value = d.getCard2Player()
         cardTotalValue = card1Value + card2Value
        
        playerCard.text =  String(card1Value)+","+String(card2Value)
        //playerCard2.text =  String(card2Value)
    
    moneyLabel.text = "Money we have \(initialMoney) "
        
        cardTotal.text = "\(cardTotalValue)"
    
        var dcard1Value = d.getDealerCard()
        println("d value is \(dcard1Value)")
        //dealerCard1.text = String(dcard1Value)
        dealerCard.text =  String(dcard1Value)+","
        foldCard.text = "Fold Card"
        
        
    
    }
    
    

    @IBAction func cardHit(sender: AnyObject) {
    
        
        var hitCard = d.getHitCard()
        playerCard.text  = playerCard.text! + "," + String(hitCard)
        var  newTotal : Int
        newTotal = cardTotalValue + hitCard
        cardTotal.text = "\(newTotal)"
        if newTotal > 21{
            println("You LOST ! ")
            clear()
        }
        
      
    }
    
    func clear () {
        enteredBet.text = "0"
        playerCard.text = "0"
         cardTotal.text = "0"
        dealerCard.text = "0"
        foldCard.text = "0"
        
    }
    
    @IBOutlet weak var enteredBet: UITextField!
    
    @IBAction func playerStands(sender: AnyObject) {
    
       var dealersAnotherCard = d.getAnotherCard4Dealer()
       foldCard.text =  String(dealersAnotherCard)
    
    }


}
