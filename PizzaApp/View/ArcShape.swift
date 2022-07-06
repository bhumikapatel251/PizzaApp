//
//  ArcShape.swift
//  PizzaApp
//
//  Created by Bhumika Patel on 06/07/22.
//

import SwiftUI
// Arc arrow swipe direction
struct ArcShape: Shape {
    func path(in rect: CGRect) -> Path{
        return Path{path in
            let midwidth = rect.width / 2
            let width = rect.width
            path.move(to: .zero)
            path.addCurve(to: CGPoint(x: width, y: 0), control1: CGPoint(x: midwidth, y: -80), control2: CGPoint(x: midwidth, y: -80))
        }
    }
}

