//
//  AddressView.swift
//  sampelOrder
//
//  Created by Sampel on 30/06/2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Form{
            Section{
                TextField("name", text: $order.name)
                TextField("Street Address", text: $order.Address)
                TextField("Email", text: $order.email)
                TextField("Zip code", text: $order.code)
                
            }
            
            Section{
                NavigationLink{
                    checkOutView(order: order)
                }label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        AddressView(order: Order())
            
        }
    }
}
