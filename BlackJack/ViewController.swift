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
    var shuffleFlag = 0
    
    @IBAction func deckCreate(sender: AnyObject) {
        shuffleFlag = 1
        if num == 0 {
        d.dealCard()
        d.shuffle()
            if( enteredBet.text == ""){
                gameStatus.text = "Enter BET MIN 1$. Press Deal"
            }
            else{
            gameStatus.text = "PRESS DEAL !"
            }
        }
        else{
         gameStatus.text = "Cannot shuffle before 5 rounds"
        
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
        
        gameStatus.text = "ENTER BET AND PRESS SHUFFLE CARDS"
        moneyLabel.text = "Money we have \(initialMoney)$"
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
    var dcard1Value = 0
    var dealFlag = 0
    var dealPressed = 0
    var playAgainFlag = 0
    @IBAction func dealCards(sender: AnyObject) {
        if shuffleFlag != 0 && enteredBet.text != ""  && enteredBet.text.toInt() != 0 {
            dealFlag = 1
        num++
        
        
        if num  > 5 {
            self.num = 0
            clear()
        }
        
                
            
            roundCount.text = "\(num)"
            
        
        card1Value = d.getCard1Player()
         card2Value = d.getCard2Player()
         cardTotalValue = card1Value + card2Value
        
        playerCard.text =  String(card1Value)+","+String(card2Value)
        //playerCard2.text =  String(card2Value)
    
    moneyLabel.text = "Money we have \(initialMoney) $"
        
        cardTotal.text = "\(cardTotalValue)"
    
        dcard1Value = d.getDealerCard()
        println("d value is \(dcard1Value)")
        //dealerCard1.text = String(dcard1Value)
        dealerCard.text =  String(dcard1Value)+","
        foldCard.text = "Fold Card"
        gameStatus.text = "Game started. Do you wanna HIT/STAND ?"
        
        }
        else if(shuffleFlag != 1){
            gameStatus.text = "You need to shuffle for 1st game."
        }
        else if (enteredBet.text.toInt() == 0) || (enteredBet.text == "" ){
            gameStatus.text = "ENTER BET MIN 1$. Press Deal"
        }
        else{
         gameStatus.text = " To start 1st game shuffle & enter bet min 1$"
            }
        
    }
    
    
    @IBOutlet weak var gameStatus: UILabel!
    
    var hitFlag = 0

    @IBAction func cardHit(sender: AnyObject) {
       
        if(dealFlag == 1){
            hitFlag = 1
        var hitCard = d.getHitCard()
        playerCard.text  = playerCard.text! + "," + String(hitCard)
        var  newTotal : Int
        gameStatus.text = "Do you wanna HIT/STAND ?"
        cardTotalValue = cardTotalValue + hitCard
        cardTotal.text = "\(cardTotalValue)"
        if cardTotalValue > 21{
            dealFlag = 0
            gameStatus.text = "YOU LOST. DO you wanna play again?"
            println("You LOST ! ")
         initialMoney = initialMoney - enteredBet.text.toInt()!
            println("Initial money is \(initialMoney)$")
            moneyLabel.text = "Money now we have \(initialMoney)$ "
            if(initialMoney==0){
                gameStatus.text = "Cannot play. You have no money"
            }

        }
        else if cardTotalValue == 21 {
            gameStatus.text = "YOU GOT BLACKJACK ! Press Stand"
            }
        }
        else{
            gameStatus.text = "You need to press Deal First."
        }
        
      
    }
    
    func clear () {
        enteredBet.text = ""
        playerCard.text = "0"
         cardTotal.text = "0"
        dealerCard.text = "0"
        foldCard.text = "0"
        
    }
    
    @IBOutlet weak var enteredBet: UITextField!
    
    @IBAction func playerStands(sender: AnyObject) {
    
        if (dealFlag == 1){
       var dealersAnotherCard = d.getAnotherCard4Dealer()
       foldCard.text =  String(dealersAnotherCard)
        
        var dealerCardsTotal = dcard1Value + dealersAnotherCard
        
        while( dealerCardsTotal <= 16){
            
            var oneMoreDealerCard = d.getAnotherCard4Dealer()
            foldCard.text = foldCard.text! + "," + String(oneMoreDealerCard)
            dealerCardsTotal = dealerCardsTotal + oneMoreDealerCard
        }
        
        
            
        if dealerCardsTotal > 16 && dealerCardsTotal > cardTotalValue && dealerCardsTotal <= 21 {
            
            
             initialMoney = initialMoney - enteredBet.text.toInt()!
            
            
            
            if(initialMoney==0){
                gameStatus.text = "Cannot play. You have no money"
            }
            else{
                gameStatus.text = "Dealer Wins. Do you wanna play again?"
            }
            moneyLabel.text = "Money now we have \(initialMoney)$ "
            
        }
        else if dealerCardsTotal > 21{
            gameStatus.text = "YOU WON.Do you wanna play again?"
            var betValue = 0
            betValue =  1 * enteredBet.text.toInt()!
            initialMoney = initialMoney + betValue
            moneyLabel.text = "Money we now have \(initialMoney)$ "

        }
        else if (dealerCardsTotal == 21 && cardTotalValue == 21) {
            gameStatus.text = "Push!, Game Finished. Do you wanna play again."
            foldCard.text = foldCard.text
            
        }
        else if (dealerCardsTotal > 16 && dealerCardsTotal == cardTotalValue ){
            gameStatus.text = "Push!, Game Finished. Do you wanna play again."
            foldCard.text = foldCard.text
        }
        else{
            var betValue = 0
            betValue =  enteredBet.text.toInt()!
            
            initialMoney = 1 * initialMoney + betValue
            gameStatus.text = "You Won. Do you wanna play again? "
            moneyLabel.text = "Money we now have \(initialMoney)$ "
        }
    }
        
        else{
            gameStatus.text = "Dealer cannot draw before Player"
        }
    }
    
    

    @IBAction func nextGame(sender: AnyObject) {
        if(roundCount.text?.toInt() > 0){
            playAgainFlag = 1
        clear()
        gameStatus.text = "New Game .Enter Bet and Press Deal !"
    
        }
        else{
            gameStatus.text = "You have to play 1 game first."
        }
        }
    
    
   
    

}
