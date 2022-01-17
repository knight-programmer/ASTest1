//
//  CountryModel.swift
//  CountryApp
//
//  Created by Akash Katoch on 15/01/22.
//

import Foundation

struct CountryModel: Decodable{
    var name: String
    var region: String
    var alpha2Code, alpha3Code: String
    var borders: [String]
    var currencies: [CurrencyModel]
    var languages: [LanguageModel]
    
    struct LanguageModel: Decodable{
        var name: String?
        var iso639_1: String?
    }

    struct CurrencyModel: Decodable{
        var name: String?
        var code: String?
        var symbol: String?
    }
}

