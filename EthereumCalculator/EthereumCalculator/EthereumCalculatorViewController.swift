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
                guard let a = Double(usd.ethUSDAAmount) else { return }
                guard let balanceEntered = self.etherBalanceTextField.text else { return }
                guard let b = Double(balanceEntered) else { return }
                let total = a * b
                self.balanceLabel.text = String("$\(total)")
                self.temp = String("$\(total)")
                
                let alert = UIAlertController(title: "\(self.temp)", message: nil, preferredStyle: .alert)
                let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAlert)
                
                self.present(alert, animated: true, completion: nil)
                
                // Alert controller works when I put it into the function, but not when I have it run in the calculateButtonTapped. Fix this later.
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
    
    //MARK: - Internal Properties
    
    var temp = "Nothing Yet :("

}
