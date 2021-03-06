//
//  Home.swift
//  PizzaApp
//
//  Created by Bhumika Patel on 05/07/22.
//

import SwiftUI

struct Home: View {
    @State var selectedPizza: PizzaViewModel = Pizza[0]
    @State var swipeDirection: Alignment = .center
    @State var animatePizza: Bool = false
    @State var pizzaSize: PizzaS = .medium
    @Namespace var animation
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
//        .background(content: {
//            Rectangle()
//                .fill(Color("BG"))
//                .ignoresSafeArea()
//        })
        .padding(15)
    }
    @ViewBuilder
    func AnimatedSlider()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            LazyHStack(spacing: 0){
                ForEach(Pizza){pizza in
                    let index = getIndex(pizza: pizza)
                    let mainIndex = getIndex(pizza: selectedPizza)
                    VStack(spacing: 10){
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
                    //changing view based swipe
                    .rotationEffect(.init(degrees: mainIndex == index ? 0 : (index > mainIndex ? 180 : -180)))
                    .offset(x: -CGFloat(mainIndex) * size.width, y: index == mainIndex ? 0 : 40)
                }
            }
            PizzaView()
                .padding(.top,150)
            
        }
        .padding(.horizontal,-15)
        .padding(.top,25)
    }
    @ViewBuilder
    func PizzaView()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            ZStack(alignment: .top){
                ZStack{
                    Image(selectedPizza.pizzaImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                    //background powder field
                        .background(alignment: .top, content: {
                            Image("powder3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width)
                                .offset(y: -30)
                        })
                        .scaleEffect(1.05, anchor: .top)
                }
                .scaleEffect(pizzaSize == .large ? 1.1 : (pizzaSize == .medium ? 1 : 0.9))
                   
                
                ZStack(alignment: .top){
                    //Hiding if its first slide
                    if Pizza.first?.id != selectedPizza.id{
                        // left side arrow
                        ArcShape()
                            .trim(from: 0.05, to: 0.3)
                            .stroke(Color.gray, lineWidth: 1)
                            .offset(y: 12)
                        // arrow Image
                        Image(systemName: "chevron.left")
                            .foregroundColor(.gray)
                            .rotationEffect(.init(degrees: -30))
                            .offset(x: -(size.width / 2) + 30, y: -9)
                    }
                    //Hiding last one
                    if Pizza.last?.id != selectedPizza.id{
                        // right side arrow
                        ArcShape()
                            .trim(from: 0.68, to: 0.95)
                            .stroke(Color.gray, lineWidth: 1)
                            .offset(y: 12)
                        // arrow Image
                        Image(systemName: "chevron.left")
                            .foregroundColor(.gray)
                            .rotationEffect(.init(degrees: 200))
                            .offset(x: (size.width / 2) - 30, y: -9)
                    }
                    
                        
                    //price attribute
                    HStack{
                        Text("$")
                            .font(.callout)
                            .padding(.horizontal,-4)
                        Text(selectedPizza.pizzaPrice)
                            .font(.largeTitle.bold())
                    }
                    .offset(y: -65)
                    
                }
                
            }
            
            //rotation will be based on Direction
            .rotationEffect(.init(degrees: animatePizza ? (swipeDirection == .leading ? -360 : 360) : 0))
            .offset(y: size.height / 2)
            // adding Gestures
            .gesture(
            DragGesture()
                .onEnded{value in
                    let translation = value.translation.width
                    let index = getIndex(pizza: selectedPizza)
                    
                    if animatePizza{return}
                    
                    //if for left swipe
                    if translation < 0 && -translation > 50 && index != (Pizza.count - 1){
                        swipeDirection = .leading
                        handleSwipe()
                    }
                    //for right swipe
                    if translation > 0 && translation > 50 && index > 0{
                        swipeDirection = .trailing
                        handleSwipe()
                    }
                }
            )
//            HStack{
//                ForEach(["SMALL", "MEDIUM", "LARGE"], id: \.self){text in
//                    Text(text)
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .foregroundColor(pizzaSize == text ? Color.orange : .white)
//                        .padding(.vertical,20)
//                        .overlay(alignment: .bottom, content: {
//                            if pizzaSize == text{
//                                Circle()
//                                    .fill(Color.orange)
//                                    .frame(width: 7, height: 7)
//                                    .offset(y: 3)
//                                    .matchedGeometryEffect(id: "SIZETAB", in: animation)
//                            }
//                        })
//                        .contentShape(Rectangle())
//                        .onTapGesture {
//                            withAnimation{
//                                pizzaSize = text
//
//                            }
//                        }
//                }
//            }
            HStack{
                ForEach(PizzaS.allCases,id: \.rawValue){size in
                    Button{
                        withAnimation{
                            pizzaSize = size
                        }
                    }label: {
                        Text(size.rawValue)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(pizzaSize.rawValue == size.rawValue ? Color.orange : .white)
                            .padding()
                            .overlay(alignment: .bottom, content: {
                                if pizzaSize.rawValue == size.rawValue{
                                    Circle()
                                        .fill(Color.orange)
                                        .frame(width: 7, height: 7)
                                        .offset(y: 3)
                                        .matchedGeometryEffect(id: "SIZETAB", in: animation)
                                }
                            })
                    }
                }
            }
            
            .padding(.horizontal,33)
            .background{
                ZStack(alignment: .top){
                    Rectangle()
                        .trim(from: 0.25, to: 1)
                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                    Rectangle()
                        .trim(from: 0, to: 0.17)
                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                    Text("SIZE")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .offset(y: -7)
                }
            }
            .padding(.horizontal,20)
            .padding(.top,10)
        }
        .padding(.top)
    }
    // Handle swipe
    func handleSwipe(){
        let index = getIndex(pizza: selectedPizza)
        if swipeDirection == .leading{
          //  print("Left")
            withAnimation(.easeOut(duration: 0.85)){
            selectedPizza = Pizza[index + 1]
                animatePizza = true
            }
        }
        if swipeDirection == .trailing{
          //  print("Right")
            withAnimation(.easeOut(duration: 0.85)){
            selectedPizza = Pizza[index - 1]
                animatePizza = true
            }
        }
        //Restoring after finishing job
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            animatePizza = false
        }
    }
    //pizza index
    func getIndex(pizza: PizzaViewModel)->Int{
        return Pizza.firstIndex{ CPizza in
            CPizza.id == pizza.id
        } ?? 0
    }
    // price string
//    func priceAttributedString(value: String)->AttributedString{
//        var attrString = AttributedString(stringLiteral: value)
//        if let range = attrString.range(of: "$"){
//            attrString[range].font = .system(.callout, weight: .bold)
//        }
//        return attrString
//    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum PizzaS: String,CaseIterable{
    case small = "SMALL"
    case medium = "MEDIUM"
    case large = "LARGE"
}
