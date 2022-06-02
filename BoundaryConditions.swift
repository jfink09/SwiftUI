//
//  BoundaryConditions.swift
//  VascularGame
//
//  Created by Jason Fink on 6/2/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct Ceiling: View {
    
    let width: CGFloat = 2000
    let height: CGFloat = 20
    
    var body: some View {
        
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor((Color(#colorLiteral(red: 0.431372549, green: 0.007843137255, blue: 0.007843137255, alpha: 1))))
    }
}

struct Floor: View {
    
    let width: CGFloat = 2000
    let height: CGFloat = 20
    
    var body: some View {
        
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor((Color(#colorLiteral(red: 0.431372549, green: 0.007843137255, blue: 0.007843137255, alpha: 1))))
    }
}
