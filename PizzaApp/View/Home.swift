//
//  Home.swift
//  PizzaApp
//
//  Created by Bhumika Patel on 05/07/22.
//

import SwiftUI

struct Home: View {
    @State var selectedPizza: Pizza = Pizza[0]
    var body: some View {
        VStack{
            HStack{
                Button{
                    
                } label: {
                    Image(systemName: "square.grid.2x2")
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                }
                Spacer()
                Button{
                    
                } label: {
                    Image(systemName: "person")
                        .foregroundColor(.white)
                        .frame(width: 38, height: 38)
                        .clipShape(Circle())
                }
            }
            .overlay{
                Text("EATPIZZA")
                    .font(.title)
            }
            Text("Select Your Pizza".uppercased())
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top,15)
            AnimatedSlider()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(15)
    }
    @ViewBuilder
    func AnimatedSlider()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            LazyHStack(spacing: 0){
                ForEach(Pizza){pizza in
                    VStack(spacing: 0){
                        Text(pizza.pizzaTitle)
                            .font(.largeTitle.bold())
                        Text(pizza.pizzaDescription)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal)
                            .padding(.top,10)
                    }
                    .frame(width: size.width, height: size.height, alignment: .top)
                }
            }
            PizzaView()
        }
        .padding(.horizontal,-15)
        .padding(.top,35)
    }
    @ViewBuilder
    func PizzaView()->some View{
        let 
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
