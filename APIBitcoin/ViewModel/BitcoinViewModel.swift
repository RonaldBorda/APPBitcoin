//
//  BitcoinViewModel.swift
//  APIBitcoin
//
//  Created by Ronald Meliton Borda Bernaola on 11/07/22.
//

import Foundation
class BitcoinViewModel{
    var bitcoins = [String: Rate]()
    
    let URL_API: String = "https://api.coingecko.com/api/v3/exchange_rates"
    
    func getDataFromAPI() async{
        guard let url = URL(string: URL_API) else { return }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoder = try? JSONDecoder().decode(Bitcoin.self, from: data){
                DispatchQueue.main.async(execute: {
                    decoder.rates.forEach{ bitcoin in
                        print(bitcoin)
                        self.bitcoins[bitcoin.key] = bitcoin.value
                    }
                })
            }
            
        }catch{
            print("Error found")
        }
    }
    
}
