//
//  decodifier.swift
//  StatusCovid19
//
//  Created by Mac1 on 16/12/20.
//

import Foundation
struct decodifier: Codable {
    let country: String
    let deaths: Int
    let recovered: Int
    let cases: Int
    let countryInfo: CountryInfo
}
struct CountryInfo: Codable {
    let flag: String
}
