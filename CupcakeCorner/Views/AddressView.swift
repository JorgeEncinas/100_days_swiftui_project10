//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Jorge Encinas on 7/21/25.
//
import SwiftUI

struct AddressView : View {
    @Bindable var order : Order
    // `Bindable` property wrapper creates the missing bindings for us
    //  produces two-way bindings, able to work with the `@Observable` macro
    //  without having to use `State` to create local data.
    //  You'll use it a lot.
    
    // You'll see that your data stays saved no matter which screen you're on.
    
    var body : some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
                //You could also add it to the NavLink
            }.disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack() {
        AddressView(order: Order())
    }
}
