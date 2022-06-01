//
//  Obstacle.swift
//  VascularGame
//
//  Created by Jason Fink on 6/1/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct Obstacle: View {
    
    let width: CGFloat = 40
    let height: CGFloat = 40
    
    var body: some View {
        
        Circle()
            .frame(width: width, height: height)
            .foregroundColor(Color(#colorLiteral(red: 0.6115235697, green: 0, blue: 0.03921568627, alpha: 1)))
    }
}
