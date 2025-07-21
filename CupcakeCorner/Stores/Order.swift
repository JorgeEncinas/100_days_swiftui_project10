//
//  oRDER.swift
//  CupcakeCorner
//
//  Created by Jorge Encinas on 7/18/25.
//
import SwiftUI

@Observable
class Order : Codable {
    enum CodingKeys : String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress : Bool {
        if (name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty ) {
            return false
        }
        return true
    }
    
    var cost : Decimal {
        var baseCost : Decimal = Decimal(quantity) * 2
        baseCost += Decimal(type) / 2 //Complicated cakes cost more.
        if extraFrosting {
            baseCost += 1
        }
        if addSprinkles {
            baseCost += 0.5
        }
        return baseCost
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
}
