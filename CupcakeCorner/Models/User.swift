//
//  User.swift
//  CupcakeCorner
//
//  Created by Jorge Encinas on 7/18/25.
//
import SwiftUI

@Observable
class User : Codable {
    enum CodingKeys : String, CodingKey {
        case _name = "name" //You need one case per property you want to save, alongside the raw value containing the name you desire.
        // so for _name we want `name`
    }
    var name = "Johnny"
}

