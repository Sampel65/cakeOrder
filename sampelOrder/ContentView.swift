//
//  ContentView.swift
//  sampelOrder
//
//  Created by Sampel on 30/06/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("select your cake type", selection: $order.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper( "number of cakes:\(order.quantity)", value: $order.quantity, in: 1...30)
                }
                
                Section{
                    Toggle("Add extra flavour", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled{
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section{
                    NavigationLink{
                        AddressView(order: order)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationBarTitle("FunkyRoyal Cake")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
