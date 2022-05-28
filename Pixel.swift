//
//  Pixel.swift
//  Vascular
//
//  Created by Jason Fink on 5/27/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct Pixel: View {
    let size: CGFloat
    let color: Color
    
    var body: some View {
        Circle()
            .frame(width: size, height: size)
            .foregroundColor(color)
    }
}
