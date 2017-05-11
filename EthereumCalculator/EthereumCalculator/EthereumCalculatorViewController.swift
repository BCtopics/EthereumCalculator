//
//  EthereumCalculatorViewController.swift
//  EthereumCalculator
//
//  Created by Bradley GIlmore on 5/11/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class EthereumCalculatorViewController: UIViewController, UITextFieldDelegate {

    func calculatePrice() {
        EthPriceController.fetchUSDollarAmount(completion: { (wallet) in
            guard let usd = wallet else { NSLog("wallet in fetchUSDDollarAmount was nil"); return }
            DispatchQueue.main.async {
                let total = Double(usd.ethUSDAAmount)! * Double(self.etherBalanceTextField.text!)! // Fix Bangs
                self.balanceLabel.text = String(total)
            }
        })

    }

    // MARK: - IBActions
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        calculatePrice()
    }
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var balanceLabel: UITextField!
    @IBOutlet weak var etherBalanceTextField: UITextField!

}
