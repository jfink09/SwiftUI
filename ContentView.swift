//
//  ContentView.swift
//  VascularGame
//
//  Created by Jason Fink on 6/1/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wbcPosition = CGPoint(x: 200, y: 700)
    @State private var obstPosition = CGPoint(x: 200, y: 100)

    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                        Pixel(size: 50, color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .position(self.wbcPosition)
                        Obstacle()
                            .position(self.obstPosition)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color(#colorLiteral(red: 0.3525061763, green: 0, blue: 0, alpha: 0.9)))
        }
        .edgesIgnoringSafeArea(.all)
    }
}
