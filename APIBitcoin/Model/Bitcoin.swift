//
//  Bitcoin.swift
//  APIBitcoin
//
//  Created by Ronald Meliton Borda Bernaola on 11/07/22.
//

import Foundation

struct Bitcoin: Decodable {
    let rates: [String: Rate]
}

struct Rate: Decodable {
    let name, unit: String
    let value: Double
    let type: TypeEnum
}

enum TypeEnum: String, Decodable {
    case commodity = "commodity"
    case crypto = "crypto"
    case fiat = "fiat"
}


