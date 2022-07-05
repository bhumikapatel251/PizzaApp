//
//  PizzaViewModel.swift
//  PizzaApp
//
//  Created by Bhumika Patel on 05/07/22.
//

import SwiftUI

struct PizzaViewModel: Identifiable{
    var id: String = UUID().uuidString
    var pizzaImage: String
    var pizzaTitle: String
    var pizzaDescription: String
    var pizzaPrice: String
}

var Pizza: [PizzaViewModel] = [
    PizzaViewModel(pizzaImage: "Pizza1", pizzaTitle: "Chessy Pizza", pizzaDescription: "Creamy Sauce, mozzarella, cheese", pizzaPrice: "150"),
    PizzaViewModel(pizzaImage: "Pizza2", pizzaTitle: "Pepperoni Pizza", pizzaDescription: "parmesan cheese,Creamy Sauce, mozzarella, red pepper flakes", pizzaPrice: "180"),
    PizzaViewModel(pizzaImage: "Pizza3", pizzaTitle: "Classic red Pizza", pizzaDescription: "Creamy Sauce, mozzarella,feta, red bell pepper", pizzaPrice: "210")
]
