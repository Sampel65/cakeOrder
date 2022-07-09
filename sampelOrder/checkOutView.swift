//
//  checkOutView.swift
//  sampelOrder
//
//  Created by Sampel on 30/06/2022.
//

import SwiftUI

struct checkOutView: View {
    @ObservedObject var order : Order
    
    @State private var  confirmationMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://media.istockphoto.com/photos/chocolate-cupcake-picture-id506920600?k=20&m=506920600&s=612x612&w=0&h=5rkoUzKAZ8eroTSvMEI31AKdxCfVzIFi-oaqpuWC8KQ="), scale: 3)
                { image in image
                        .resizable()
                        .scaledToFit()
                }
                placeholder : {
                    ProgressView()
                }
                .frame(height : 233)
                
                Text("Your Total Order is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order"){
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
                    .frame(width: 320, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank You!", isPresented: $showingConfirmation){
            Button("Ok"){}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func  placeOrder() async {
        guard let encoded = try?  JSONEncoder().encode(order) else {
            print("failed to encode order")
            return
        }
        
        let  url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for:  request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcake is on its way!"
            showingConfirmation = true
        } catch {
            print("Check out failed")
        }
        
    }
}

struct checkOutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        checkOutView(order: Order())
    }
    }
}
