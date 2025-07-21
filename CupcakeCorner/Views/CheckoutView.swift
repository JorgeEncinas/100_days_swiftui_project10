//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Jorge Encinas on 7/21/25.
//
import SwiftUI

struct CheckoutView : View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    func placeOrder() async {
        // 1. Convert our `order` into JSON
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        // 2. Tell Swift how to send that data over a net call
        let url = URL(string: "https://reqres.in/api/cupcakes")
        guard let urlUnwrapped = url else {
            print("URL invalid")
            return
        }
        var request = URLRequest(url : urlUnwrapped)
        //Must force URL, otherwise type is `URL?`
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // 3. Run that request and process the response.
        do {
            let (data, _) = try await URLSession.shared.upload(
                for: request,
                from: encoded
            )
            let decodedOrder = try JSONDecoder().decode(
                Order.self,
                from: data
            )
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed : \(error.localizedDescription)")
        }
        
        
    }
    
    var body : some View {
        ScrollView {
            VStack {
                
                AsyncImage(
                    url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                    scale: 3
                ) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message : {
            Text(confirmationMessage)
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
