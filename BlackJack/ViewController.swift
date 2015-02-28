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
    @IBOutlet weak var playerCard: UILabel!
    
    
    @IBOutlet weak var dealerCardTotalLabel: UILabel!
    
    @IBOutlet weak var cardTotal: UILabel!
    
    @IBOutlet weak var playerCard2: UILabel!
    
    
    @IBOutlet weak var gameStatus: UILabel!
    
    @IBOutlet weak var enteredBet: UITextField!
    
    @IBOutlet weak var Player2Card: UILabel!
    
    @IBOutlet weak var enteredBetPlayer2: UITextField!
    
    
    @IBOutlet weak var Player2CardTotal: UILabel!
    
    let logic = Logic()
    var d = Deck()
    var num=0
    var initialMoney = 100
    var player2initialMoney = 100
    var shuffleFlag = 0
    var card1Value = 0
    var card2Value = 0
    var cardTotalValue = 0
    var dcard1Value = 0
    var dealFlag = 0
    var dealPressed = 0
    var playAgainFlag = 0
    var hitFlag = 0
    var countDecks = 3;
    
    var player2card1Value = 0
    var player2card2Value = 0
    var player2cardTotalValue = 0
    
    var player1flag: Bool = true
    var player2flag: Bool = true
    var player1win :Int = 1
    var player2win : Int = 1
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    
    @IBOutlet weak var moneyLabelPlayer2: UILabel!
    
    @IBAction func deckCreate(sender: AnyObject) {
        shuffleFlag = 1
        if num == 0 {
            d.dealCard(countDecks)
            d.shuffle()
            if( enteredBet.text == ""){
                gameStatus.text = "Enter BET MIN 1$. Press Deal"
            }
            else{
                gameStatus.text = "PRESS DEAL!"
            }
        }
        else{
            gameStatus.text = "Cannot shuffle before 5 rounds"
            
        }
        
    }
    
    
    
    @IBOutlet weak var turnLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //countDecks = Singelton.sharedInstance.noOfDecks
        
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
    
    
    @IBAction func dealCards(sender: AnyObject) {
        if shuffleFlag != 0 && enteredBet.text != ""  && enteredBet.text.toInt() != 0 {
            dealFlag = 1
            num++
            
            
            if num  > 5 {
                self.num = 0
                clear()
            }
            
            var playerList:[Player] = []
            
            
            
            
            
            
            roundCount.text = "\(num)"
            
            
            card1Value = d.getCard1Player()
            card2Value = d.getCard2Player()
            cardTotalValue = card1Value + card2Value
            
            player2card1Value = d.getCard1Player()
            player2card2Value = d.getCard2Player()
            player2cardTotalValue = player2card1Value + player2card2Value
            
            
            playerCard.text =  String(card1Value)+","+String(card2Value)
            //playerCard2.text =  String(card2Value)
            
            Player2Card.text = String(player2card1Value)+","+String (player2card2Value)
            
            moneyLabel.text = "Money player1 have \(initialMoney) $"
            
            moneyLabelPlayer2.text = "  Money player2 have \(player2initialMoney) $"
            
            cardTotal.text = "\(cardTotalValue)"
            Player2CardTotal.text = "\(player2cardTotalValue)"
            dcard1Value = d.getDealerCard()
            
            println("d value is \(dcard1Value)")
            //dealerCard1.text = String(dcard1Value)
            dealerCard.text =  String(dcard1Value)+","
            foldCard.text = "Fold Card"
            gameStatus.text = "Game started. Player1 wanna HIT/STAND ?"
            
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
    
    
    
    
    
    
    @IBAction func cardHit(sender: AnyObject) {
        if(player1flag){
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
                    gameStatus.text = "P1 LOST. Press Stand for P2's chance?"
                    println("You LOST ! ")
                    initialMoney = initialMoney - enteredBet.text.toInt()!
                    println("Initial money is \(initialMoney)$")
                    moneyLabel.text = "Money now we have \(initialMoney)$ "
                    if(initialMoney==0){
                        gameStatus.text = "Cannot play. You have no money"
                        player1flag = false
                    }
                    
                }
                else if cardTotalValue == 21 {
                    gameStatus.text = "P1 GOT BLACKJACK ! Press Stand"
                    //player1flag = false
                }
            }
            //else{
              //  gameStatus.text = "You need to press Deal First."
                
            //}
            
            
        } else {
            //if(dealFlag == 1){
                hitFlag = 1
                var hitCard = d.getHitCard()
                Player2Card.text  = Player2Card.text! + "," + String(hitCard)
                var  newTotal : Int
                gameStatus.text = "Do you wanna HIT/STAND ?"
                player2card2Value = player2cardTotalValue + hitCard
                Player2CardTotal.text = "\(player2card2Value)"
                if player2card2Value > 21{
                    dealFlag = 0
                    gameStatus.text = "P2 lost. Press Stand for dealers turn"
                    player2win = 0
                    println("You LOST ! ")
                    player2initialMoney = player2initialMoney - enteredBetPlayer2.text.toInt()!
                    println("Initial money is \(player2initialMoney)$")
                    moneyLabelPlayer2.text = "Money now we have \(player2initialMoney)$ "
                    if(player2initialMoney==0){
                        gameStatus.text = "Cannot play. You have no money"
                        //player2flag = false
                    }
                    
                }
                else if player2card2Value == 21 {
                    gameStatus.text = "P2 GOT BLACKJACK. Press Stand for Dealer turn"
                    //player2flag = false
                }
          //  }
            //else{
              //  gameStatus.text = "You need to press Deal First."
                
            //}
            
            
        }
        
    }
    
    func clear () {
        enteredBet.text = ""
        playerCard.text = "0"
        cardTotal.text = "0"
        dealerCard.text = "0"
        foldCard.text = "0"
        Player2CardTotal.text = "0"
        dealerCardTotalLabel.text = "0"
        enteredBetPlayer2.text = ""
        Player2Card.text = "0"
        
    }
    
    
    
    @IBAction func playerStands(sender: AnyObject) {
        if(player1flag == true){
            player1flag = false
            gameStatus.text = "Player2 wanna HIT/STAND ?"
        }
        else {
            player2flag = false
            //if (dealFlag == 1){
                var dealersAnotherCard = d.getAnotherCard4Dealer()
                foldCard.text =  String(dealersAnotherCard)
                
                var dealerCardsTotal = dcard1Value + dealersAnotherCard
                
                while( dealerCardsTotal <= 16){
                    
                    var oneMoreDealerCard = d.getAnotherCard4Dealer()
                    foldCard.text = foldCard.text! + "," + String(oneMoreDealerCard)
                    dealerCardsTotal = dealerCardsTotal + oneMoreDealerCard
                }
                dealerCardTotalLabel.text = "\(dealerCardsTotal)"
                
                if (dealerCardsTotal > 21 && player2win != 0){
                    gameStatus.text = "Players WON.Do you wanna play again?"
                    var betValue = 0
                    betValue =  1 * enteredBet.text.toInt()!
                    initialMoney = initialMoney + betValue
                    moneyLabel.text = "Money we now have \(initialMoney)$ "
                    player2initialMoney = player2initialMoney + enteredBetPlayer2.text.toInt()!
                    
                    moneyLabelPlayer2.text = "Money player2 have \(player2initialMoney)"
                    
                    return
                }else if(dealerCardsTotal == 21 && dealerCardsTotal > cardTotalValue && dealerCardsTotal > player2cardTotalValue){
                    initialMoney = initialMoney - enteredBet.text.toInt()!
                    
                    
                    
                    if(initialMoney==0){
                        gameStatus.text = "Cannot play. You have no money"
                    }
                    else{
                        gameStatus.text = "Dealer got Blackjack. Do you wanna play again?"
                    }
                    moneyLabel.text = "Money now we have \(initialMoney)$ "
                    
            }

                
        if dealerCardsTotal > 16 && dealerCardsTotal > cardTotalValue && dealerCardsTotal < 21 {
                    
                    
                    initialMoney = initialMoney - enteredBet.text.toInt()!
                    
                    
                    
                    if(initialMoney==0){
                        gameStatus.text = "Cannot play. You have no money"
                    }
                    else{
                        gameStatus.text = "Dealer Wins against P1. Do you wanna play again?"
                    }
                    moneyLabel.text = "Money now we have \(initialMoney)$ "
                    
                }
            
            
                else if (dealerCardsTotal > 16 && dealerCardsTotal == cardTotalValue ){
                    gameStatus.text = "Push!, Game Finished. Do you wanna play again."
                    foldCard.text = foldCard.text
                }
                else{
                    var betValue = 0
                    betValue =  enteredBet.text.toInt()!
                    
                    initialMoney = 1 * initialMoney + betValue
                    gameStatus.text = "Player1 wins. Do you wanna play again? "
                    moneyLabel.text = "Money we now have \(initialMoney)$ "
                }
            
            if dealerCardsTotal > 16 && dealerCardsTotal > player2cardTotalValue && dealerCardsTotal <= 21 {
                
                
                player2initialMoney = player2initialMoney - enteredBetPlayer2.text.toInt()!
                
                
                
                
                if(player2initialMoney==0){
                    gameStatus.text = "Cannot play. You have no money"
                }
                else{
                    gameStatus.text = "Dealer Wins against P2"
                }
                moneyLabelPlayer2.text = "Money now we have \(player2initialMoney)$ "
                
            }
                
                
            else if (dealerCardsTotal > 16 && dealerCardsTotal == player2cardTotalValue ){
                gameStatus.text = "Push!, Game Finished. Do you wanna play again."
                foldCard.text = foldCard.text
            }
            else{
                var betValue = 0
                betValue =  enteredBet.text.toInt()!
                
                player2initialMoney = 1 * player2initialMoney + betValue
                gameStatus.text = "Player2 wins. Do you wanna play again? "
                moneyLabelPlayer2.text = "Money we now have \(player2initialMoney)$ "
            }

            //}
            
            
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
