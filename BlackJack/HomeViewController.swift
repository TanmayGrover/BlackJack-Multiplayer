//
//  SecondViewController.swift
//  BlackJack
//
//  Created by Tanmay Grover on 2/27/15.
//  Copyright (c) 2015 Tanmay Grover. All rights reserved.
//

import Foundation


import UIKit


class HomeViewController: UIViewController   {
    
    override  func viewDidLoad() {
      super.viewDidLoad()
    }
    
    override func  didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBOutlet weak var deckCount: UITextField!

            
    @IBAction func start() {
        
        var singelton = Singelton.sharedInstance
        singelton.noOfDecks = deckCount.text.toInt()!
    }


}