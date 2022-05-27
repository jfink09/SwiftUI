//
//  Obstacle.swift
//  Helicopter
//
//  Created by Jason Fink on 5/25/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct Obstacle: View {
    
    let width: CGFloat = 20
    let height: CGFloat = 120
    
    var body: some View {
        
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor(Color.green)
    }
}
