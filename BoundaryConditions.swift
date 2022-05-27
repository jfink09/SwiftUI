//
//  BoundaryConditions.swift
//  Helicopter
//
//  Created by Jason Fink on 5/26/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct Ceiling: View {
    
    let width: CGFloat = 2000
    let height: CGFloat = 20
    
    var body: some View {
        
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor(Color.green)
    }
}

struct Floor: View {
    
    let width: CGFloat = 2000
    let height: CGFloat = 20
    
    var body: some View {
        
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor(Color.green)
    }
}
