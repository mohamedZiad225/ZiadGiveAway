//
//  Giveaway.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//


public struct GiveawayDTO: Decodable {
    let id: Int
    let title: String
    let description: String
    let image: String
    let worth: String
    let platforms: String
    let users: Int
    let type: String
    let status: String
    let end_date: String
}
