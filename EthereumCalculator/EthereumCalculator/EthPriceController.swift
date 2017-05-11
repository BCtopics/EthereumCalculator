//
//  EthPriceController.swift
//  EthereumCalculator
//
//  Created by Bradley GIlmore on 5/11/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

class EthPriceController{
    
    static let baseURL = URL(string: "https://api.etherscan.io/api")
    
    //MARK: - FetchUSDDollarAmount Function
    
    static func fetchUSDollarAmount(completion: @escaping (_ responses: EthWallet?) -> Void) {
        
        guard let usdURL = baseURL else { fatalError("USD/URL is nil") }
        
        let urlParameters = [
            "module" : "stats",
            "action": "ethprice",
            "apikey":"DCKQBK1DZJ5NNV25KDWJSSQHTARUDXBY2J"
        ]
        
        
        NetworkController.performRequest(for: usdURL, httpMethod: .get, urlParameters: urlParameters, body: nil) { (data, error) in
            
            guard let data = data else { return }
            let responseDataString = String(data: data, encoding: .utf8) ?? ""
            
            guard error == nil else { print("Error: \(String(describing: error?.localizedDescription))"); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { completion(nil); return }
            
            
            guard let walletDictionary = jsonDictionary["result"] as? [String: Any] else { return }
            guard let newWalletDictionary = walletDictionary["ethusd"] as? String else { return }
            let usdWallet = EthWallet(ethUSDAmount: newWalletDictionary)
            print(usdWallet.ethUSDAAmount)
            
            
            completion(usdWallet)
            
        }
    }
}
